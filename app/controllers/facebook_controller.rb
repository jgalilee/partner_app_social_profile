class FacebookController < ApplicationController
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

    session[:profile] = { type: :facebook, token: token.as_hash }
  end

  protected

  def facebook_authorize_uri(app_id, redirect_uri)
    facebook_client_settings[:authorize_url] % [app_id, redirect_uri]
  end

  def facebook_default_client
    @default_client ||= facebook_client(facebook_client_settings)
  end

  def facebook_client(settings)
    app_id = settings[:app_id]
    secret_key = settings[:secret_key]
    site_url = settings[:site_url]
    token_url = settings[:token_url]
    @client ||= OAuth2::Client.new(app_id, secret_key, {
      site: site_url,
      token_url: token_url
    })
  end

  def facebook_client_settings
    if !defined?(@settings)
      settings = YAML.load(File.open("#{Rails.root}/config/social/facebook.yml"))
      @settings = settings[Rails.env].symbolize_keys
    end
    @settings
  end
end
