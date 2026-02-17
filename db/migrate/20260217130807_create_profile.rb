class CreateProfile < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :phone_number
      t.string :contact_email
      t.text :description
      t.timestamps
    end
  end
end
