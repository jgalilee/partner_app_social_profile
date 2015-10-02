class SessionsController < ApplicationController
  include FacebookClient

  before_filter :authenticate_user, except: :logout

  def index; end

  def logout
    session.clear
  end

  def error; end

  protected

  def authenticate_user
    if facebook_has_session?
      redirect_to profile_url
    end
  end
end
