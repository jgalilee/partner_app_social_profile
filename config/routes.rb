Rails.application.routes.draw do
  root controller: :sessions, action: :index

  resource :sessions, only: [:index] do
    resource :facebook, controller: :facebook, only: [:new] do
      get :redirect, action: :create
    end
  end
end
