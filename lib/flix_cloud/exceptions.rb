class FlixCloud::Error < StandardError; end
class FlixCloud::SaveError < FlixCloud::Error; end
class FlixCloud::CreateError < FlixCloud::Error; end
class FlixCloud::Unauthorized < FlixCloud::Error; end
class FlixCloud::RequestFailed < FlixCloud::Error; end
