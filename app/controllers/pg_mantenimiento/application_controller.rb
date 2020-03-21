module PgMantenimiento
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # esto es medio choto, porque obliga a tener devise pero bueno
    before_action :authenticate_user!

    before_action do
      @empresa = PgMantenimiento.config.nombre_empresa
    end
  end
end
