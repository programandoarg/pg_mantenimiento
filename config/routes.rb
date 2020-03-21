PgMantenimiento::Engine.routes.draw do
  get 'backups/index'
  get 'backups/show'
  get 'backups/descargar'
  get 'base_de_datos/status'
  get 'filesystem/status'
end
