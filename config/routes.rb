Rails.application.routes.draw do

  root 'top#top'
  post '/top/guest_sign_in', to: 'top#new_guest'

  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :rooms, only: [:index, :show]

  # ユーザー機能
  resources :users, only: [:show] do
    resources :relationships,   only: [:create, :destroy]
    get :follows,   on: :member
    get :followers, on: :member
  end
end
