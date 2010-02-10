class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :fname
      t.string :lname
      t.string :dob

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
