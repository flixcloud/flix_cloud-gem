class FlixCloud::Job < FlixCloud::Record

  attr_accessor :id, :initialized_at, :api_key, :recipe_id, :response

  record_column :file_locations, 'FileLocations'

  def initialize(attrs={})
    super
    self.shortcut_attributes = attrs
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

    unless recipe_id
      self.errors << "recipe_id is required"
    end

    unless api_key
      self.errors << "api_key is required"
    end

    errors.empty?
  end

  def save
    return false unless valid?

    self.response = FlixCloud::Response.new(post('jobs', to_xml))

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
      xml.tag!("recipe-id", recipe_id)

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
        end
      end
    end

    xml.target!
  end


protected

  def shortcut_attributes=(attrs)
    translated_attributes = {}

    attrs.each do |key, value|
      if match = key.to_s.match(/^(input|output|watermark)_(url|user|password)$/)
        file_type = match[1].to_sym
        parameter_type = match[2].to_sym

        if parameter_type == :url
          translated_attributes.deep_merge!(:file_locations => { file_type => { :url => value}})
        else
          translated_attributes.deep_merge!(:file_locations => { file_type => { :parameters => { parameter_type => value}}})
        end
      end
    end

    self.attributes = translated_attributes unless translated_attributes.empty?
  end

end
