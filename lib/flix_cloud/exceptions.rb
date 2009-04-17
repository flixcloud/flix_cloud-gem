class FlixCloud::Error < StandardError; end
class FlixCloud::SaveError < FlixCloud::Error; end
class FlixCloud::CreateError < FlixCloud::Error; end
class FlixCloud::ServerBrokeConnection < FlixCloud::Error; end
class FlixCloud::RequestTimeout < FlixCloud::Error; end
class FlixCloud::ConnectionRefused < FlixCloud::Error; end
