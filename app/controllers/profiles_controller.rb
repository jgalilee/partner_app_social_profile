class ProfilesController < ApplicationController
  include FacebookClient

  before_filter :facebook_token_present?

  before_action :load_facebook_profile
  after_action :save_facebook_profile

  def profile
    @contact = Salesforce::Contact.where(facebookid__c: @profile.id).first
    if @contact.blank?
      @contact = Salesforce::Contact.create_from_facebook_profile!(@profile)
    end
  end

  def edit; end

  def update
    @contact = Salesforce::Contact.where(facebookid__c: @profile.id).first
  end

  private

  def load_facebook_profile
    @profile ||= facebook_load_profile
  end

  def save_facebook_profile
    facebook_save_token(facebook_token)
  end

end
