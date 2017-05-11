class Post < ActiveRecord::Base
# has_many method allows a post instance to have many commetns related to it,
 # and also provides methods that allow us to retrieve somments that belong to a post
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
