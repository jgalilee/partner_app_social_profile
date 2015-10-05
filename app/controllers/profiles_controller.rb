class ProfilesController < ApplicationController
  include FacebookClient

  before_filter :facebook_token_present?

  def profile
    facebook_profile = facebook_load_profile

    @profile = Profile.facebook.find_by(social_id: facebook_profile.id)
    if @profile.blank?
      profile_factory = FacebookProfileFactory.new(facebook_profile.id, facebook_profile)
      @profile = profile_factory.create
    end
    @contact = @profile.contact
    @profile = facebook_profile
  end

  def edit
    @profile = facebook_load_profile
    @contact = Profile.facebook.find_by(social_id: @profile.id).contact
  end

  def update
    @profile = facebook_load_profile
    @contact = Profile.facebook.find_by(social_id: @profile.id).contact
    @contact.update(contact_params)

    redirect_to profile_url
  end

  private

  def contact_params
    params.permit(:mailingcity, :mailingcountry, :mailingpostalcode, :mailingstreet, :mailingstate)
  end

end
