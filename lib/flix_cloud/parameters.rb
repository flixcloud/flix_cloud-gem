class FlixCloud::Parameters < FlixCloud::File

  attr_accessor :user, :password

  def valid?
    self.errors = []

    unless user
      self.errors << "user is required"
    end

    unless password
      self.errors << "password is required"
    end

    errors.empty?
  end

end
