Gem::Specification.new do |s|
  s.name = "ing"
  s.version = "0.0.0"
  s.date = "2020-11-20"
  s.summary = "ING to YNAB"
  s.description = "Convert the ING exported CSV to a YNAB compatible version"
  s.authors = ["Cezar Halmagean"]
  s.email = "cezar@mixnadgo.com"
  s.files = ["lib/ing.rb"]
  s.homepage = "https://rubygems.org/gems/ing"
  s.license = "MIT"
  s.add_development_dependency "minitest", ">= 5.8"
  s.add_development_dependency "minitest-reporters", ">= 1.1"
end
