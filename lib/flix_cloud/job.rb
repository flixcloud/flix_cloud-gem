class FlixCloud::Job < FlixCloud::Record

  attr_accessor :id, :initialized_at, :api_key, :recipe_id, :recipe_name, :response, :notification_url, :pass_through

  record_column :file_locations, 'FileLocations'
  record_column :cue_points, 'CuePoints'
  record_column :recipe_settings, 'RecipeSettings'

  def initialize(attrs={})
    super
    self.shortcut_attributes = attrs
  end

  def self.status_of(id, api_key)
    FlixCloud::JobStatus.new(get("jobs/#{id}/status", api_key).body)
  end

  def valid?
    self.errors = []

    if file_locations
      unless file_locations.valid?
        self.errors << {:file_locations => file_locations.errors}
      end
    else
      self.errors << "file_locations is required"
    end

    if recipe_id || recipe_name
      if recipe_id && recipe_name
        self.errors << "recipe_id and recipe_name cannot both be used"
      end
    else
      self.errors << "recipe_id or recipe_name is required"
    end

    unless api_key
      self.errors << "api_key is required"
    end

    errors.empty?
  end

  def save
    return false unless valid?

    self.response = post('jobs', to_xml)

    if response.success?
      self.id = response.body_as_hash['job']['id']
      self.initialized_at = response.body_as_hash['job']['initialized_job_at']
    else
      self.errors = response.errors
    end

    response.success?
  end

  def save!
    raise FlixCloud::SaveError unless save
    true
  end

  def self.create(attrs={})
    job = new(attrs)
    job.save
    job
  end

  def self.create!(attrs={})
    job = create(attrs)
    raise FlixCloud::CreateError unless job.id
    job
  end

  def to_xml
    xml = Builder::XmlMarkup.new

    xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"

    xml.tag!("api-request") do
      xml.tag!("api-key", api_key)

      if recipe_name
        xml.tag!("recipe-name", recipe_name)
      else
        xml.tag!("recipe-id", recipe_id)
      end

      if notification_url
        xml.tag!('notification-url', notification_url)
      end

      if pass_through
        xml.tag!('pass-through', pass_through)
      end

      if cue_points
        xml.tag!("cue-points") do
          if cue_points.event
            xml.event do
              if cue_points.event.cue_point && !cue_points.event.cue_point.empty?
                cue_points.event.cue_point.each do |cue_point|
                  xml.tag!('cue-point') do
                    xml.name(cue_point.name) if cue_point.name
                    xml.time(cue_point.time) if cue_point.time
                    if cue_point.parameter && !cue_point.parameter.empty?
                      cue_point.parameter.each do |parameter|
                        xml.parameter do
                          xml.key(parameter.key) if parameter.key
                          xml.value(parameter.value) if parameter.value
                        end
                      end
                    end
                  end
                end
              end
            end
          end

          if cue_points.navigation
            xml.navigation do
              if cue_points.navigation.cue_point && !cue_points.navigation.cue_point.empty?
                cue_points.navigation.cue_point.each do |cue_point|
                  xml.tag!('cue-point') do
                    xml.name(cue_point.name) if cue_point.name
                    xml.time(cue_point.time) if cue_point.time
                    if cue_point.parameter && !cue_point.parameter.empty?
                      cue_point.parameter.each do |parameter|
                        xml.parameter do
                          xml.key(parameter.key) if parameter.key
                          xml.value(parameter.value) if parameter.value
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      if file_locations
        xml.tag!("file-locations") do
          if file_locations.input
            xml.input do
              xml.url(file_locations.input.url)
              if file_locations.input.parameters
                xml.parameters do
                  xml.user(file_locations.input.parameters.user)
                  xml.password(file_locations.input.parameters.password)
                end
              end
            end
          end

          if file_locations.output
            xml.output do
              xml.url(file_locations.output.url)
              if file_locations.output.parameters
                xml.parameters do
                  xml.user(file_locations.output.parameters.user)
                  xml.password(file_locations.output.parameters.password)
                end
              end
            end
          end

          if file_locations.watermark
            xml.watermark do
              xml.url(file_locations.watermark.url)
              if file_locations.watermark.parameters
                xml.parameters do
                  xml.user(file_locations.watermark.parameters.user)
                  xml.password(file_locations.watermark.parameters.password)
                end
              end
            end
          end

          if file_locations.thumbnails
            xml.thumbnails do
              xml.url(file_locations.thumbnails.url)
              xml.prefix(file_locations.thumbnails.prefix)
              if file_locations.thumbnails.parameters
                xml.parameters do
                  xml.user(file_locations.thumbnails.parameters.user)
                  xml.password(file_locations.thumbnails.parameters.password)
                end
              end
            end
          end
        end
      end
    end

    if recipe_settings
      xml.tag!('recipe-settings') do
        FlixCloud::RecipeSettings.recipe_attributes.each do |attribute|
          xml.tag!(attribute, recipe_settings.send(attribute)) if recipe_settings.send(attribute)
        end
      end
    end

    xml.target!
  end


protected

  def shortcut_attributes=(attrs)
    translated_attributes = {}

    attrs.each do |key, value|
      if match = key.to_s.match(/^(input|output|watermark|thumbnails)_(url|user|password|prefix)$/)
        file_type = match[1].to_sym
        parameter_type = match[2].to_sym

        if parameter_type == :url
          translated_attributes.deep_merge!(:file_locations => { file_type => { :url => value}})
        elsif parameter_type == :prefix
          translated_attributes.deep_merge!(:file_locations => { file_type => { :prefix => value}})
        else
          translated_attributes.deep_merge!(:file_locations => { file_type => { :parameters => { parameter_type => value}}})
        end
      end
    end

    self.attributes = translated_attributes unless translated_attributes.empty?
  end

end
