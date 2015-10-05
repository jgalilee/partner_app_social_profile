Rails.application.routes.draw do
  root controller: :application, action: :root

  constraints SetupConstraint.new do
    get :logout, controller: :sessions, action: :logout
    get :notice, controller: :sessions, action: :notice
    get :error, controller: :sessions, action: :error
    get :index, controller: :sessions, action: :index

    resource :sessions, only: [:index] do
      resource :facebook, controller: :facebook, only: [:new] do
        get :callback, action: :create
      end
    end

    get "profile", controller: :profiles, action: :profile
    get "profile/edit", controller: :profiles, action: :edit, as: :edit_profile
    put "profile", controller: :profiles, action: :update, as: :update_profile
  end

  resource :setup, only: [:new, :create, :edit, :update]

end
