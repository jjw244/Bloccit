class Post < ActiveRecord::Base
# has_many method allows a post instance to have many commetns related to it,
 # and also provides methods that allow us to retrieve somments that belong to a post
  has_many :comments, dependent: :destroy
end
