require_dependency "pg_mantenimiento/application_controller"

module PgMantenimiento
  class BackupsController < ApplicationController
    def index
      @archivos = cliente_s3
        .list_objects(bucket: PgMantenimiento.config.s3_bucket, prefix: PgMantenimiento.config.s3_prefijo)
        .contents.sort { |a, b| b.key <=> a.key }.take 50
    end

    def show
      @archivo = cliente_s3.get_object(bucket: PgMantenimiento.config.s3_bucket, key: params[:key])
      @key = params[:key]
    rescue Aws::S3::Errors::NoSuchKey => e
      flash[:error] = "el archivo no existe"
      redirect_back fallback_location: backups_index_path
    end

    def descargar
      @archivo = cliente_s3.get_object(bucket: PgMantenimiento.config.s3_bucket, key: params[:key])
      maximos_megas = 50
      if @archivo.content_length < (maximos_megas * 1024 * 1024) # si supera el tamaño permitido
        send_data @archivo.body.read, filename: params[:key].split('/').last
      else
        @error = "no se puede descargar el archivo"
        redirect_back fallback_location: backups_index_path
      end
    rescue Aws::S3::Errors::NoSuchKey => e
      @error = "el archivo no existe"
      redirect_back fallback_location: backups_index_path
    end

    private

    def cliente_s3
      @cliente_s3 ||= Aws::S3::Client.new(
        region: ENV['PG_MANTENIMIENTO_AWS_REGION'],
        credentials: Aws::Credentials.new(
          ENV['PG_MANTENIMIENTO_AWS_ACCESS_KEY_ID'],
          ENV['PG_MANTENIMIENTO_AWS_SECRET_ACCESS_KEY']
        )
      )
    end
  end
end
