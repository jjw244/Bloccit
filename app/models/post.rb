class Post < ActiveRecord::Base
# has_many method allows a post instance to have many commetns related to it,
 # and also provides methods that allow us to retrieve somments that belong to a post
  belongs_to :topic
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
end
