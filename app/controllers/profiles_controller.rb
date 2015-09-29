class ProfilesController < ApplicationController
  include FacebookClient

  before_filter :facebook_token_present?

  before_action :load_facebook_profile
  after_action :save_facebook_profile

  def profile
    if facebook_contact.blank?
      facebook_create_contact
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
    @contact ||= Salesforce::Contact.where(facebookid__c: @profile.id).first
  end

  def facebook_create_contact
    @contact ||= Salesforce::Contact.create_from_facebook_profile!(@profile)
  end

  def load_facebook_profile
    @profile ||= facebook_load_profile
  end

  def save_facebook_profile
    facebook_save_token(facebook_token)
  end

  def contact_params
    params.permit(:mailingcity, :mailingcountry, :mailingpostalcode, :mailingstreet, :mailingstate)
  end

end
