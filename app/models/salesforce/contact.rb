module Salesforce
  class Contact < SObject
    resolve_table_name

    def self.create_from_facebook_profile!(profile)
      contact = self.new
      contact.email = profile.email
      contact.facebookid__c = profile.id
      contact.firstname = profile.first_name
      contact.lastname = profile.last_name
      contact.birthdate = profile.birthday
      contact.save!
      contact
    end
  end
end
