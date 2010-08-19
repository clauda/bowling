class AddColumnImageToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :photo, :string
  end

  def self.down
    remove_column :profiles, :photo
  end
end
