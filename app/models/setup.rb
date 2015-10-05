class Setup < ActiveRecord::Base
  validates :app_id, :secret_key, :root_url, presence: true
end
