require 'rails_heroku_connect_helper'

RSpec.describe Profile, type: :model do

  let!(:email) { "user@example.com" }
  let!(:contact) { Salesforce::Contact.create!(email: email) }

  describe "#validation" do
    it "disallows non-valid social network types" do
      profile = Profile.new
      profile.social_type = :my_network
      profile.social_id = "xyz"
      profile.contact = contact
      profile.save

      expect(profile.save).to eq(false)
    end

    it "allows social networks in particular types" do
      profile = Profile.new
      profile.social_type = :facebook
      profile.social_id = "xyz"
      profile.contact = contact
      profile.save

      expect(profile.save).to eq(true)
    end
  end

end
