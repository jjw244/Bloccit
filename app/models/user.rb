class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
# #2  register an inline callback directly after the before_save callback.
 #{ self.email = email.downcase } is the code that will run when the callback executes.
  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :member }

# #3  use Ruby's validates function to ensure that name is present and has a maximum and minimum length
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
# #4  validate password with two separate validations 1: executes if password_digest is nil.  2: min length 6 char & valid if empty
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
# #5  validate that email is present, unique, case insensitive, has a minimum length, has a maximum length, and that it is a properly formatted email address.
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

# #6  use Ruby's has_secure_password: "adds methods to set and authenticate against a BCrypt password.
 #This mechanism requires you to have a password_digest attribute".
  has_secure_password

  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
