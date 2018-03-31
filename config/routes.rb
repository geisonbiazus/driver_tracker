Rails.application.routes.draw do
  post 'companies', to: 'companies#create'
end
