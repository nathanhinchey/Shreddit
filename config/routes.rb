Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new]
  delete 'session' => 'sessions#destroy', as: 'logout'
end
