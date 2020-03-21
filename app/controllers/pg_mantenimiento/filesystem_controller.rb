require_dependency "pg_mantenimiento/application_controller"

module PgMantenimiento
  class FilesystemController < ApplicationController
    def status
      @stat = Sys::Filesystem.stat('/')
      @bloques = @stat.blocks
      @tamaño_disco = @stat.blocks * @stat.block_size
      @disponible = @stat.blocks_available * @stat.block_size
      # @libre = @stat.blocks_free * @stat.block_size
      @usado = @tamaño_disco - @disponible
    end
  end
end


