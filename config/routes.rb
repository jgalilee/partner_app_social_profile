Rails.application.routes.draw do
  root controller: :sessions, action: :index

  resource :sessions, only: [:index] do
    resource :facebook, controller: :facebook, only: [:new] do
      get :callback, action: :create
      get :logout, action: :logout
    end
  end

  get "profile", controller: :profiles, action: :profile
  get "profile/edit", controller: :profiles, action: :edit, as: :edit_profile
  put "profile", controller: :profiles, action: :update, as: :update_profile
end
