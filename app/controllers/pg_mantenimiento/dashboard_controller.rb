require_dependency "pg_mantenimiento/application_controller"

module PgMantenimiento
  class DashboardController < ApplicationController
    rescue_from Error, with: :error

    def error(error)
      @mensaje = error.message
      render 'error'
    end

    def status
      filesystem
      tablas
      @ultimo_backup = backups(1).first
      @fecha_ultimo_backup = fecha_archivo(@ultimo_backup.key)
      @tiempo_desde_ultimo_backup = Time.zone.now - @fecha_ultimo_backup
    end

    private

    def filesystem
      @stat = Sys::Filesystem.stat('/')
      @bloques = @stat.blocks
      @tamaño_disco = @stat.blocks * @stat.block_size
      @espacio_disponible = @stat.blocks_available * @stat.block_size
      @espacio_utilizado = @tamaño_disco - @espacio_disponible
      @porcentaje_utilizado = 100 * @espacio_utilizado / @tamaño_disco
    end

    def tablas
      @tamaño_tablas = tamaño_tablas
      @tablas = PgMantenimiento.config.modelos.map do |modelo|
        {
          nombre: modelo.model_name.human,
          cantidad_filas: modelo.count,
          tamaño: @tamaño_tablas[modelo.table_name]
        }
      end.sort { |a, b| b[:tamaño] <=> a[:tamaño] }
    end

    def tamaño_tablas
      query = <<-SQL
        SELECT *, pg_size_pretty(total_bytes) AS total
            , pg_size_pretty(index_bytes) AS INDEX
            , pg_size_pretty(toast_bytes) AS toast
            , pg_size_pretty(table_bytes) AS TABLE
          FROM (
          SELECT *, total_bytes-index_bytes-COALESCE(toast_bytes,0) AS table_bytes FROM (
              SELECT c.oid,nspname AS table_schema, relname AS TABLE_NAME
                      , c.reltuples AS row_estimate
                      , pg_total_relation_size(c.oid) AS total_bytes
                      , pg_indexes_size(c.oid) AS index_bytes
                      , pg_total_relation_size(reltoastrelid) AS toast_bytes
                  FROM pg_class c
                  LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
                  WHERE relkind = 'r'
          ) a
        ) a;
      SQL
      res = ActiveRecord::Base.connection.execute(query)
      res.to_a.map {|a| [a['table_name'], a['total_bytes']]}.to_h
    end
  end
end
