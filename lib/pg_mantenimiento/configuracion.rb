module PgMantenimiento
  class Configuracion
    attr_accessor :nombre_empresa
    attr_accessor :s3_bucket
    attr_accessor :s3_prefijo

    def initialize
      @nombre_empresa = 'Empresa'
      @s3_bucket = 'programando2020'
      @s3_prefijo = 'backups/cursosonline'
    end
  end
end
