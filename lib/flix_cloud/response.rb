class FlixCloud::Response

  attr_accessor :code, :body, :errors, :body_as_hash

  def initialize(response)
    self.code = response.code
    self.body = response.to_s
    self.body_as_hash = Crack::XML.parse(response.to_s)
    self.errors = []
    process_response_xml
  end

  def success?
    201 == code.to_i
  end


protected

  def process_response_xml
    if body_as_hash['errors'] && body_as_hash['errors'].is_a?(Hash) && body_as_hash['errors']['error']
      self.errors = Array(body_as_hash['errors']['error'])
    end
  end

end
