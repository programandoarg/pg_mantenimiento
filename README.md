# PgMantenimiento
Una pantalla que muestra
- Un listado de los backups del sistema
- Utilización del espacio en disco
- Cantidad de filas en las tablas y espacio ocupado


## Instalación

En el Gemfile:
```ruby
gem 'pg_mantenimiento', git: 'https://github.com/programandoarg/pg_mantenimiento.git', tag: 'v1.0.1'
```

Luego ejecutar:
```bash
$ bundle
```

## Configuración

Crear el archivo config/initializers/pg_mantenimiento.rb
```ruby
PgMantenimiento.configurar do |c|
  c.nombre_empresa = "Programando"
  
  # configuración del bucket S3 donde están hosteados los backups
  c.aws_s3 = {
    bucket: 'programando2020',
    prefijo: 'backups/programando', # la carpeta donde están los backups del proyecto
    region: 'sa-east-1',
    access_key_id: ENV['PG_MANTENIMIENTO_AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['PG_MANTENIMIENTO_AWS_SECRET_ACCESS_KEY'],
  }

  # modelos del sistema que se muestran en la pantalla
  c.modelos = [
    Usuario,
    Post,
    Foto
  ]

  # autenticación, para restringir qué usuarios pueden acceder a la pantalla
  # se ejecuta en el contexto del controller
  c.autenticacion do
    unless current_user.present? && current_user.admin?
      raise Pundit::NotAuthorizedError.new
    end
  end
end

```

En el routes.rb
```ruby
mount PgMantenimiento::Engine => "/pg_mantenimiento"
```

En la navbar se linkea con:
```ruby
pg_mantenimiento.root_path
```
