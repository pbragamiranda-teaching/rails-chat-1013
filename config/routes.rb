Rails.application.routes.draw do
  get 'chatrooms/show'
  devise_for :users
  root to: "pages#home"

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
