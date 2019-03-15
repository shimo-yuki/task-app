Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  resources :tasks, only: [:show, :edit, :create, :new, :update, :destroy]
  resources :users, only: [:show, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


end
