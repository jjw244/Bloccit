require 'rails_helper'

RSpec.describe Post, type: :model do
# #1  create a new instance of the Post class
  # let dynamically defines a method (post), upon first call within a spec (the it block at #2) computes and stores the returned value
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
# #3  create a parent topic for post
  let(:topic) { Topic.create!(name: name, description: description) }
# #4  associate post with topic via topic.posts.create!. This is a chained method call which creates a post for a given topic
  let(:post) { topic.posts.create!(title: title, body: body) }

  it { is_expected.to belong_to(:topic) }

# #2  test whether post has attributes named title and body -> tests for non-nil vlaue
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: title, body: body)
    end
  end
end
