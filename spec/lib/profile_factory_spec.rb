require 'rails_helper'

RSpec.describe FacebookProfileFactory do

  let!(:id) { "xyz" }
  let!(:email) { "joe.bloggs@example.com" }
  let!(:first_name) { "Joe" }
  let!(:last_name) { "Bloggs" }
  let!(:birthday) { Date.today - 25.years }
  let!(:city) { "Boulder" }
  let!(:country) { "United States" }
  let!(:postal_code) { 80302 }
  let!(:street) { "1234 Fake St" }
  let!(:state) { "CO" }
  let!(:profile_data) {
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      birthday: birthday,
      mailingcity: city,
      mailingcountry: country,
      mailingpostalcode: postal_code,
      mailingstreet: street,
      mailingstate: state
    }
  }

  describe "#create" do
    context "with valid profile data" do
      subject { FacebookProfileFactory.new(id, profile_data) }

      it "creates a contact" do
        expect { subject.create }.to change { Salesforce::Contact.count }.by(1)
      end

      it "creates a profile" do
        expect { subject.create }.to change { Profile.count }.by(1)
      end
    end

    context "with invalid profile data" do
      subject { FacebookProfileFactory.new(nil, profile_data) }

      it "does not create a contact" do
        expect { subject.create }.to_not change { Salesforce::Contact.count }
      end

      it "does not create a profile" do
        expect { subject.create }.to_not change { Profile.count }
      end
    end
  end

end
