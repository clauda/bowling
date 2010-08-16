class Profile < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :description

  has_attached_file :photo, :styles => { :normal => "640x480>", :medio => "320x240>", :thumb => "160x120>" }

end
