require_dependency "pg_mantenimiento/application_controller"

module PgMantenimiento
  class BaseDeDatosController < ApplicationController
    def status
      @tablas = PgMantenimiento.config.base_de_datos.call
    end
  end
end
