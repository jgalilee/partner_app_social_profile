class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :social_type, null: false
      t.text :social_id, null: false
      t.integer :contact_id, null: false

      t.timestamps null: false
    end
  end
end
