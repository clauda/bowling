class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      t.string :name
      t.text :description
      t.string :site

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
