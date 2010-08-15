class Post < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :categories, :class_name => "Category"
  has_many :comments

  validates_presence_of   :title, :body, :user, :slug, :published_at
  validates_uniqueness_of :slug
  validates_inclusion_of  :draft, :in => [true, false]
  validates_associated    :user

  scope :published, lambda { where("draft = ? AND published_at < ?", false, Time.current) }
  scope :search, lambda { |terms| where("title LIKE :t OR body LIKE :t", :t => "%#{terms}%") }

  before_validation :generate_slug

  def to_param
    "#{id}-#{slug}"
  end

  protected

  def generate_slug
    self.slug = title unless slug.present?
    self.slug = slug.parameterize
  end

end
