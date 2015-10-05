class FacebookController < ApplicationController
  include FacebookClient

  def new
    redirect_to facebook_callback_uri
  end

  def create
    oauth2_client = facebook_default_client
    grant = oauth2_client.auth_code
    token = grant.get_token(params[:code], {
      redirect_uri: facebook_redirect_url,
      parse: :query
    })
    facebook_save_token(token)

    redirect_to profile_url
  rescue => e
    logger.error(e)

    redirect_to error_url
  end

end
