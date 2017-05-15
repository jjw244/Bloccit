require 'rails_helper'

RSpec.describe Comment do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
# #1  create a comment with an associated user
  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }

# #2  test that a comment belongs to a user and a post
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
# #3  test that a comment's body is present and has a minimum length of five
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body atttribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end

  describe "after_create" do
# #22  initialize (but don't save) a new comment for post
    before do
      @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
    end

# #23  favorite post then expect FavoriteMailer will receive a call to new_comment
    it "sends an email to users who have favorited the post" do
      # favorite = user.favorites.create(post: post) --> callback calls favorite
      expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))

      @another_comment.save!
    end
  end
end
