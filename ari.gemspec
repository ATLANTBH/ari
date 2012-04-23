$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ari/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ari"
  s.version     = Ari::VERSION
  s.authors     = ["Pasalic Zaharije"]
  s.email       = ["zaharije@atlantbh.com"]
  s.homepage    = "http://www.atlantbh.com"
  s.summary     = "ARI - Active Record Insector"
  s.description = "Inspects and navigate through Activerecord data via relations defined in models"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.0"

  s.add_development_dependency "sqlite3"
end
