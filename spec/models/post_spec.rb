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
# #1  create a user to associate with a test post
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
# #2  associate user with post when we create the test post
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  it { is_expected.to have_many(:comments) }

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to belong_to(:topic) }
# #1-A  test that Post validates the presence of title, body, and topic
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
# #2-A  test that Post validates the lengths of title and body
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

# #2  test whether post has attributes named title and body -> tests for non-nil vlaue
  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end
end
