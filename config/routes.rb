APP_NAME::Application.routes.draw do
  resources :users, only: %i(index) do
    resource :snapshot, only: %i(show create)
  end

  root to: 'users#index'
end
