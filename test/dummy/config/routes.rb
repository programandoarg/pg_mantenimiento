Rails.application.routes.draw do
  mount PgMantenimiento::Engine => "/pg_mantenimiento"
end
