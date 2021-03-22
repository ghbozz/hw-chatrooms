Rails.application.routes.draw do
  devise_for :users

  resources :chatrooms, only: %i(index new create show) do
    resources :messages, only: %i(create)
  end

  resources :messages, only: %i(destroy)
end
