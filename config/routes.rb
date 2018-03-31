require 'sidekiq/web'

Rails.application.routes.draw do
  post 'companies', to: 'companies#create'
  post 'activity-events', to: 'activity_events#create'

  mount Sidekiq::Web => '/sidekiq'
end
