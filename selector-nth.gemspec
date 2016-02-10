Gem::Specification.new do |s|
  # Release Specific Information
  s.version = "0.1.0"
  s.date = "2016-02-09"

  # Gem Details
  s.name = "selector-nth"
  s.authors = ["Chris Siepker"]
  s.summary = %q{Sass helper functions for modifying a particular position in a selector}
  s.description = %q{}
  s.email = "chris@cimmanon.org"
  s.homepage = "https://github.com/cimmanon/selector-nth"

  # Gem Files
#  s.files = %w(README.txt)
  s.files = Dir.glob("lib/**/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")
  s.files += Dir.glob("templates/**/*.*")

  # Gem Bookkeeping
  s.rubygems_version = %q{1.3.6}
  s.add_dependency("compass", [">= 1.0"])
end
