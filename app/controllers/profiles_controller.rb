class ProfilesController < ApplicationController
  include FacebookClient

  before_filter :facebook_token_present?

  before_action :load_facebook_profile

  def profile
    if profile.blank?
      create_profile
    end
  end

  def edit
    facebook_contact
  end

  def update
    facebook_contact.update(contact_params)

    redirect_to profile_url
  end

  private

  def facebook_contact
    @contact ||= Profile.facebook.find(social_id: @profile.id)
  end

  def create_profile
    profile_factory = FacebookProfileFactory.new(@profile.id, @profile)
    @profile ||= profile_factory.create!
  end

  def load_facebook_profile
    @profile ||= facebook_load_profile
  end

  def contact_params
    params.permit(:mailingcity, :mailingcountry, :mailingpostalcode, :mailingstreet, :mailingstate)
  end

end
