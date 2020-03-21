require 'aws-sdk-s3'
require 'slim-rails'
require 'jquery-rails'
require 'bootstrap'
require 'bootstrap-datepicker-rails'

module PgMantenimiento
  class Engine < ::Rails::Engine
    isolate_namespace PgMantenimiento

    config.i18n.default_locale = :es
  end
end
