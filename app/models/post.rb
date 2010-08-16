class Post < ActiveRecord::Base
  default_scope order('published_at DESC')
  cattr_reader :per_page
  @@per_page = 10
  acts_as_taggable

  belongs_to :user
  has_and_belongs_to_many :categories, :class_name => "Category"
  has_many :comments

  validates_presence_of   :title, :body, :user, :slug
  validates_uniqueness_of :slug
  validates_inclusion_of  :draft, :in => [true, false]
  validates_associated    :user

  scope :published, lambda { where("draft = ? AND published_at < ?", false, Time.current) }
  scope :search, lambda { |terms| where("title LIKE :t OR body LIKE :t", :t => "%#{terms}%") }

  before_validation :generate_slug

protected

  def generate_slug
    self.slug = title unless slug.present?
    self.slug = slug.parameterize
  end

end
