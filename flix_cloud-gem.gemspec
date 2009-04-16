# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flix_cloud-gem}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Sutton"]
  s.date = %q{2009-04-16}
  s.email = %q{nate@sevenwire.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]
  s.files = [
    "LICENSE",
    "README.markdown",
    "Rakefile",
    "VERSION.yml",
    "lib/flix_cloud.rb",
    "lib/flix_cloud/exceptions.rb",
    "lib/flix_cloud/extensions/hash.rb",
    "lib/flix_cloud/file.rb",
    "lib/flix_cloud/file_locations.rb",
    "lib/flix_cloud/job.rb",
    "lib/flix_cloud/notification.rb",
    "lib/flix_cloud/parameters.rb",
    "lib/flix_cloud/record.rb",
    "lib/flix_cloud/response.rb",
    "test/flix_cloud/file_locations_test.rb",
    "test/flix_cloud/file_test.rb",
    "test/flix_cloud/input_file_test.rb",
    "test/flix_cloud/job_test.rb",
    "test/flix_cloud/notification_test.rb",
    "test/flix_cloud/output_files_test.rb",
    "test/flix_cloud/parameters_test.rb",
    "test/flix_cloud/record_test.rb",
    "test/flix_cloud/response_test.rb",
    "test/flix_cloud/watermark_file_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/zencoder/flix_cloud-gem}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Gem for integrating with http://flixcloud.com}
  s.test_files = [
    "test/flix_cloud/file_locations_test.rb",
    "test/flix_cloud/file_test.rb",
    "test/flix_cloud/input_file_test.rb",
    "test/flix_cloud/job_test.rb",
    "test/flix_cloud/notification_test.rb",
    "test/flix_cloud/output_files_test.rb",
    "test/flix_cloud/parameters_test.rb",
    "test/flix_cloud/record_test.rb",
    "test/flix_cloud/response_test.rb",
    "test/flix_cloud/watermark_file_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<crack>, [">= 0.1.1"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0.9.2"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<crack>, [">= 0.1.1"])
      s.add_dependency(%q<rest-client>, [">= 0.9.2"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<crack>, [">= 0.1.1"])
    s.add_dependency(%q<rest-client>, [">= 0.9.2"])
  end
end
