require_dependency "pg_mantenimiento/application_controller"

module PgMantenimiento
  class BackupsController < ApplicationController
    def index
      @archivos = backups(50)
    end

    def show
      @archivo = cliente_s3.head_object(bucket: PgMantenimiento.config.aws_s3[:bucket], key: params[:key])
      @key = params[:key]
    rescue Aws::S3::Errors::NoSuchKey => e
      flash[:error] = "El archivo no existe"
      redirect_back fallback_location: backups_index_path
    rescue Aws::S3::Errors::InvalidObjectState => e
      flash[:error] = "No se puede acceder al archivo"
      redirect_back fallback_location: backups_index_path
    end

    def descargar
      @archivo = cliente_s3.head_object(bucket: PgMantenimiento.config.aws_s3[:bucket], key: params[:key])
      maximos_megas = 50
      if @archivo.content_length < (maximos_megas * 1024 * 1024) # si supera el tamaño permitido
        @archivo = cliente_s3.get_object(bucket: PgMantenimiento.config.aws_s3[:bucket], key: params[:key])
        send_data @archivo.body.read, filename: nombre_archivo(params[:key])
      else
        flash[:error] = "No se puede descargar el archivo"
        redirect_back fallback_location: backups_index_path
      end
    rescue Aws::S3::Errors::NoSuchKey => e
      flash[:error] = "El archivo no existe"
      redirect_back fallback_location: backups_index_path
    rescue Aws::S3::Errors::InvalidObjectState => e
      flash[:error] = "No se puede acceder al archivo"
      redirect_back fallback_location: backups_index_path
    end
  end
end
