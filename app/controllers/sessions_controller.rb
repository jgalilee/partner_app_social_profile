class SessionsController < ApplicationController
  include FacebookClient

  before_filter :authenticate_user

  def index
  end

  protected

  def authenticate_user
    if facebook_has_session?
      redirect_to profile_url
    end
  end
end
