class CreateSetup < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.string :app_id
      t.string :secret_key
      t.string :root_url
    end
  end
end
