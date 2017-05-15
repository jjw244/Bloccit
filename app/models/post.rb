class Post < ActiveRecord::Base
# has_many method allows a post instance to have many commetns related to it,
 # and also provides methods that allow us to retrieve somments that belong to a post
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
# #4  add the votes association to Post
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  after_create :create_vote
  after_create :create_favorite

  default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
# #9  find the up votes for a post by passing value: 1 to where
     votes.where(value: 1).count
  end

  def down_votes
# #10  find the down votes for a post by passing value: -1 to where
    votes.where(value: -1).count
  end

  def points
# #11  use ActiveRecord's sum method to add the value of all the given post's votes
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  private

   def create_vote
     user.votes.create(value: 1, post: self)
   end

   def create_favorite
     user.favorites.create(value: 1, post: self)
     post.favorites.each do |favorite|
       FavoriteMailer.new_post(favorite.user, post, self).deliver_now
     end
   end
end
