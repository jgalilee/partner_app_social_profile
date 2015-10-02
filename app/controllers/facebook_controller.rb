class FacebookController < ApplicationController
  include FacebookClient

  def new
    app_id = facebook_client_settings[:app_id]
    callback_url = facebook_client_settings[:callback_url]

    redirect_to facebook_authorize_uri(app_id, callback_url)
  end

  def create
    oauth2_client = facebook_default_client
    grant = oauth2_client.auth_code
    token = grant.get_token(params[:code], {
      redirect_uri: facebook_client_settings[:callback_url],
      parse: :query
    })
    facebook_save_token(token)

    redirect_to profile_url
  rescue => e
    logger.error(e)

    redirect_to error_url
  end

end
