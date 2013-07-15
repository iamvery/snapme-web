SeemeWeb::Application.routes.draw do
  resources :users, only: %i(index)
end
