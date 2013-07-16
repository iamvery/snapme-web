SeemeWeb::Application.routes.draw do
  resources :users, only: %i(index) do
    resource :snapshot, only: %i(create)
  end

  root to: 'users#index'
end
