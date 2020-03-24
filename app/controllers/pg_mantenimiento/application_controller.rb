module PgMantenimiento
  class ApplicationController < ActionController::Base
    include ApplicationHelper

    protect_from_forgery with: :exception

    # esto es medio choto, porque obliga a tener devise pero bueno
    before_action :authenticate_user!

    before_action do
      @empresa = PgMantenimiento.config.nombre_empresa
    end

    protected

      def backups(take = 50)
        cliente_s3
          .list_objects(bucket: PgMantenimiento.config.aws_s3[:bucket], prefix: PgMantenimiento.config.aws_s3[:prefijo])
          .contents.sort { |a, b| b.key <=> a.key }.take(take)
      end

      def cliente_s3
        @cliente_s3 ||= Aws::S3::Client.new(
          region: PgMantenimiento.config.aws_s3[:region],
          credentials: Aws::Credentials.new(
            PgMantenimiento.config.aws_s3[:access_key_id],
            PgMantenimiento.config.aws_s3[:secret_access_key]
          )
        )
      end
  end
end
