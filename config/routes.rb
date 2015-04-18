Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new]
  delete 'session' => 'sessions#destroy', as: 'logout'

  shallow do
    resources :subs do
      shallow do
        resources :posts, except: [:index] do
          resources :comments, except: [:index, :show]
        end
      end
    end
  end
end
