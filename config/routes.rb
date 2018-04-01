require 'sidekiq/web'

Rails.application.routes.draw do
  get 'activity-report', to: 'activity_report#index'
  post 'companies', to: 'companies#create'
  post 'activity-events', to: 'activity_events#create'

  mount Sidekiq::Web => '/sidekiq'
end
