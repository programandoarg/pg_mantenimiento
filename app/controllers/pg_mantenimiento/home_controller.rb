require_dependency "pg_mantenimiento/application_controller"

module PgMantenimiento
  class HomeController < ApplicationController
    def index
      s3 = Aws::S3::Client.new(
        region: ENV['PG_MANTENIMIENTO_AWS_ACCESS_KEY_ID'],
        credentials: Aws::Credentials.new(
          ENV['PG_MANTENIMIENTO_AWS_SECRET_ACCESS_KEY'],
          ENV['PG_MANTENIMIENTO_AWS_REGION']
        )
      )
      @archivos = s3
        .list_objects(bucket: 'programando2020', prefix: 'backups/cursosonline')
        .contents
    end
  end
end
