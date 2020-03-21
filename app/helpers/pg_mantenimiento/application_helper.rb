module PgMantenimiento
  module ApplicationHelper

    # a partir de la key de un archivo en S3
    def nombre_archivo(key)
      key.split('/').last
    end

    # a partir de la key de un archivo en S3
    def fecha_archivo(key)
      # DateTime.strptime(key.split('/')[2], "%Y.%m.%d.%H.%M.%S").strftime('%d/%m/%Y %H:%M')
      Time.zone.strptime("#{key.split('/')[2]} UTC", "%Y.%m.%d.%H.%M.%S %Z").strftime('%d/%m/%Y %H:%M')
    end

    def tamaño_archivo(tamaño)
      number_to_human_size tamaño, locale: :en
    end

    def show_percentage(value)
      return unless value.present?

      "#{value.round(2)} %"
    end
  end
end
