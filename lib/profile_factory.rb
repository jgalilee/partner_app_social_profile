class ProfileFactory

  def initialize(type, id, profile_data)
    @type = type
    @id = id
    if profile_data.kind_of? Hash
      profile_data = OpenStruct.new(profile_data)
    end
    @profile_data = profile_data
  end

  def create
    Profile.transaction do
      # Create the Salesforce contact. Don't save the contact, it will 
      # be saved as part of the Profile.
      contact = Salesforce::Contact.new
      contact.email = @profile_data.email
      contact.firstname = @profile_data.first_name
      contact.lastname = @profile_data.last_name
      contact.birthdate = @profile_data.birthday
      contact.mailingcity = @profile_data.mailing_city
      contact.mailingcountry = @profile_data.mailing_country
      contact.mailingpostalcode = @profile_data.mailing_postal_code
      contact.mailingstreet = @profile_data.mailing_street
      contact.mailingstate = @profile_data.mailing_state

      # Create the Profile.
      profile = Profile.new
      profile.social_type = @type
      profile.social_id = @id
      profile.contact = contact
      if !profile.save
        raise ActiveRecord::Rollback
      end
      profile
    end
  end

end
