SeemeWeb::Application.routes.draw do
  resources :users, only: %i(index)
  root to: 'users#index'
end
