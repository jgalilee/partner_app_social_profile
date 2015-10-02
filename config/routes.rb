Rails.application.routes.draw do
  root controller: :sessions, action: :index

  get :logout, controller: :sessions, action: :logout
  get :error, controller: :sessions, action: :error

  resource :sessions, only: [:index] do
    resource :facebook, controller: :facebook, only: [:new] do
      get :callback, action: :create
    end
  end

  get "profile", controller: :profiles, action: :profile
  get "profile/edit", controller: :profiles, action: :edit, as: :edit_profile
  put "profile", controller: :profiles, action: :update, as: :update_profile
end
