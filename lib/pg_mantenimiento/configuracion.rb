module PgMantenimiento
  class Configuracion
    attr_accessor :nombre_empresa
    attr_accessor :s3_bucket
    attr_accessor :s3_prefijo
    attr_accessor :base_de_datos

    def initialize
      @nombre_empresa = 'Empresa'
      @s3_bucket = 'programando2020'
      @s3_prefijo = 'backups/cursosonline'
      @base_de_datos = Proc.new do
        [
          { nombre: 'Tabla 1', cantidad_filas: 1234 },
          { nombre: 'Tabla 2', cantidad_filas: 12355 },
        ]
      end
    end
  end
end
