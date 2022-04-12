Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'
  post '/auth/sign_up', to: 'authentication#sign_up'
  resources :links
  resources :users
  get '/:id', to: 'ref#show'
end
