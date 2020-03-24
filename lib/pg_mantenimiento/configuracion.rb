module PgMantenimiento
  class Configuracion
    attr_accessor :nombre_empresa
    attr_accessor :aws_s3
    attr_accessor :modelos
    attr_reader :autenticacion_block

    def initialize
      @nombre_empresa = 'Empresa'
      @aws_s3 = {
        bucket: 'programando2020',
        prefijo: 'backups/cursosonline',
        region: 'sa-east-1',
        access_key_id: ENV['PG_MANTENIMIENTO_AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['PG_MANTENIMIENTO_AWS_SECRET_ACCESS_KEY'],
      }
      @modelos = []
    end

    def autenticacion(&block)
      @autenticacion_block = block
    end
  end
end
