Rails.application.routes.draw do
  get 'user/show'
  # devise_for :users
  devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
 
  resources :attendances, only: []
  resources :events do
    resources :attendances, only: [:create, :destroy], controller: 'attendances'
  end
  resources :users, only: [:show] do
    resources :events, only: [:new, :create]
  end

  resources :attendances, only: [] do
    member do
      delete 'remove_attendee', to: 'attendances#remove_attendee'
    end
  end
  
  root "events#index"
end
