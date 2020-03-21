require "pg_mantenimiento/engine"
require "pg_mantenimiento/configuracion"

module PgMantenimiento
  # Your code goes here...
  class << self
    attr_writer :config

    def config
      @config ||= Configuracion.new
    end

    def configurar
      yield(config)
    end
  end
end
