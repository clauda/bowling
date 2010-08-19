class RemovePaperclip < ActiveRecord::Migration

  def self.up
    remove_column :profiles, :photo_file_size
    remove_column :profiles, :photo_content_type
    remove_column :profiles, :photo_file_name
  end

  def self.down
    add_column :profiles, :photo_file_name, :string
    add_column :profiles, :photo_content_type, :string
    add_column :profiles, :photo_file_size, :integer
  end

end
