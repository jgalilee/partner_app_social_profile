class ProfilesController < ApplicationController
  include FacebookClient

  def profile
    @profile = facebook_load_profile

    facebook_save_token(facebook_token)
  end

  def edit
    @profile = facebook_load_profile

    facebook_save_token(facebook_token)
  end

end
