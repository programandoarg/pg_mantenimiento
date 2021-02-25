$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "pg_mantenimiento/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "pg_mantenimiento"
  spec.version     = PgMantenimiento::VERSION
  spec.authors     = ["Martín Rosso"]
  spec.email       = ["mrosso10@gmail.com"]
  spec.homepage    = ""
  spec.summary     = ": Summary of PgMantenimiento."
  spec.description = ": Description of PgMantenimiento."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ": Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rails', '~> 6'
  spec.add_dependency 'rails-i18n'
  spec.add_dependency 'pundit'
  spec.add_dependency "slim-rails"
  spec.add_dependency 'aws-sdk-s3', '~> 1'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'sys-filesystem'

  spec.add_development_dependency 'bootstrap-datepicker-rails', '~> 1.8'
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
end
