Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new]
  delete 'session' => 'sessions#destroy', as: 'logout'

  shallow do
    resources :subs do
      resources :posts, except: [:index]
    end
  end
end
