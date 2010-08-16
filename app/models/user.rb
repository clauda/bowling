class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :registable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :profile
  has_many :posts

  def name
    self.profile.nil? ? self.email : self.profile.name
  end

end
