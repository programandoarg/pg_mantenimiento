module PgMantenimiento
  class Error < StandardError; end

  class ApplicationController < ActionController::Base
    include ApplicationHelper

    protect_from_forgery with: :exception

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action do
      instance_eval(&PgMantenimiento.config.autenticacion_block)
    end

    before_action do
      @empresa = PgMantenimiento.config.nombre_empresa
    end

    protected

      def backups(take = 50)
        cliente_s3
          .list_objects(bucket: PgMantenimiento.config.aws_s3[:bucket], prefix: PgMantenimiento.config.aws_s3[:prefijo])
          .contents.sort { |a, b| b.key <=> a.key }.take(take)
      rescue Aws::Errors::MissingCredentialsError => e
        raise Error, 'Error de configuración. Faltan credenciales de S3'
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

      def user_not_authorized
        flash[:alert] = 'No está autorizado para realizar esa acción'
        redirect_to '/'
      end
  end
end
