class Profile < ActiveRecord::Base

  belongs_to :contact, class_name: "Salesforce::Contact"

  validates :social_type, presence: true, inclusion: { in: %w(facebook) }
  validates :social_id, presence: true
  validates :contact, presence: true

  scope :facebook, -> { where(social_type: "facebook") }

end
