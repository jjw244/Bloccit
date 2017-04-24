require 'rails_helper'

# #6  RSpec created a test for PostsController.
 # type: :controller tells RSpec to treat the test as a controller test.
 # This allows us to simulate controller actions such as HTTP requests.
RSpec.describe PostsController, type: :controller do

  # #8  create a post and assign it to my_post using let
   # use RandomData to give my_post a random title and body
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

  describe "GET #index" do
    it "returns http success" do
  # #7 the test performs a GET on the index view and expects the response to be successful
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
  # #9  created 1 post = index of one in an array, assigns is a method in ActionController::TestCase
      expect(assigns(:posts)).to eq([my_post])
    end
  end

# #10  we will use these later
  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
