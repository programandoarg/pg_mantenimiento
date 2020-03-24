PgMantenimiento::Engine.routes.draw do
  get 'backups/index'
  get 'backups/show'
  get 'backups/descargar'
  get 'dashboard/status'

  root to: 'dashboard#status'
end
