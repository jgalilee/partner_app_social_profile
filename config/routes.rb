Rails.application.routes.draw do
  root controller: :sessions, action: :index

  resource :sessions, only: [:index] do
    resource :facebook, controller: :facebook, only: [:new] do
      get :callback, action: :create
    end
  end

  get :profile, controller: :profiles, action: :profile
  get :profile, controller: :profiles, action: :edit, as: :edit_profile
end
