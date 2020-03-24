module PgMantenimiento
  module ApplicationHelper

    def nombre_archivo(key)
      # key.split('/').last
      PgMantenimiento.config.nombre_empresa.downcase.gsub(' ', '_') + ".tar"
    end

    # a partir de la key de un archivo en S3
    def fecha_archivo(key)
      Time.zone.strptime("#{key.split('/')[2]} UTC", "%Y.%m.%d.%H.%M.%S %Z")
    end

    def dmy(fecha)
      fecha.strftime('%d/%m/%Y %H:%M')
    end

    def tamaño_archivo(tamaño)
      number_to_human_size tamaño, locale: :en
    end

    def show_percentage(value)
      return unless value.present?

      "#{value.round(2)} %"
    end

    def clase_espacio_utilizado(porcentaje_utilizado)
      case porcentaje_utilizado
      when 0..80
        'text-success'
      when 80..90
        'text-warning'
      when 90..100
        'text-danger'
      end
    end

    def clase_ultimo_backup(tiempo_desde_ultimo_backup)
      if tiempo_desde_ultimo_backup < 1.day
        return 'text-success'
      end
      if tiempo_desde_ultimo_backup < 2.day
        return 'text-warning'
      end
      'text-danger'
    end
  end
end
