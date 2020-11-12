Rails.application.routes.draw do

  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    root :to => 'users/registrations#new', as: :unauthenticated_root
  end

  resources :rooms, only: [:index, :show]

  # ユーザー機能
  resources :users, only: [:show] do
    resources :relationships,   only: [:create, :destroy]
    get :follows,   on: :member
    get :followers, on: :member
  end
end
