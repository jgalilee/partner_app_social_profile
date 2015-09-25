class FacebookController < ApplicationController
  def new
    redirect_to facebook_authorize_uri("1554382644803582", "http://localhost:3000/sessions/facebook/redirect")
  end

  def create
    @code = params[:code]
  end

  protected

  def facebook_authorize_uri(app_id, redirect_uri)
    "https://www.facebook.com/dialog/oauth?client_id=#{app_id}&redirect_uri=#{redirect_uri}"
  end
end
