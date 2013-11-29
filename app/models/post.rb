class Post < ActiveRecord::Base
  belongs_to :bucket
  has_many :comments, as: :commentable

  validates :name, presence: true
  validates :description, presence: true
  validates :url, format: {with: URI::regexp(%w(http https))}, allow_blank: true
  validates_presence_of :bucket
end
