Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    root :to => 'devise/registrations#new', as: :unauthenticated_root
  end

  resources :rooms, only: [:index, :show]
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
