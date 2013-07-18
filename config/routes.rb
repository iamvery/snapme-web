APP_NAME::Application.routes.draw do
  get    '/session/new' => 'sessions#new',     as: :sign_in
  delete '/session'     => 'sessions#destroy', as: :sign_out
  match  '/auth/:provider/callback' => 'sessions#create',  via: :all
  match  '/auth/failure'            => 'sessions#failure', via: :all

  resources :users, only: %i(index) do
    resource :snapshot, only: %i(show create)
  end

  root to: 'users#index'
end
