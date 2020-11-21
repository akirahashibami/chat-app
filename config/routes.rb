Rails.application.routes.draw do

  root 'top#top'

  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :rooms, only: [:new, :index, :show, :create, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
  end

  get 'rooms/:id/group' => 'rooms#group', as: 'group'

  # ユーザー機能
  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :relationships,   only: [:create, :destroy]
    get :follows,   on: :member
    get :followers, on: :member
  end
end
