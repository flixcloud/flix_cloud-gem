class FlixCloud::Record

  attr_accessor :errors

  def initialize(attrs={})
    self.errors = []
    self.attributes = attrs
  end

  def attributes=(attrs)
    attrs.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end

  def self.record_column(attribute, klass)
    eval %{
      attr_reader :#{attribute}

      def #{attribute}=(value)
        if @#{attribute}
          @#{attribute}.attributes = value
        else
          @#{attribute} = FlixCloud::#{klass}.new(value)
        end
      end
    }
  end


protected

  def post(path, body)
    begin
      FlixCloud::Response.new(RestClient::Resource.new("https://flixcloud.com/#{path}",
                                                       :verify_ssl => OpenSSL::SSL::VERIFY_PEER).post(body, :content_type => 'application/xml', :accept => 'application/xml'))
    rescue RestClient::ServerBrokeConnection
      raise FlixCloud::ServerBrokeConnection
    rescue RestClient::RequestTimeout
      raise FlixCloud::RequestTimeout
    end
  end

end
