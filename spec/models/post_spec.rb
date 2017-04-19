require 'rails_helper'

RSpec.describe Post, type: :model do
# #1  create a new instance of the Post class
  # let dynamically defines a method (post), upon first call within a spec (the it block at #2) computes and stores the returned value
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
# #2  test whether post has attributes named title and body -> tests for non-nil vlaue
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
