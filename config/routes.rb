APP_NAME::Application.routes.draw do
  get    '/session/new' => 'sessions#new',     as: :sign_in
  delete '/session'     => 'sessions#destroy', as: :sign_out
  match  '/auth/:provider/callback' => 'sessions#create',  via: :all
  match  '/auth/failure'            => 'sessions#failure', via: :all

  resources :memberships, only: %i(create destroy)
  resource  :snapshot, only: %i(create)
  resources :teams

  root to: 'teams#index'
end
