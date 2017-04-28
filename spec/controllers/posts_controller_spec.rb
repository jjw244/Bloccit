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

# #1  a new and unsaved Post object is created
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
# #2  expect PostsController#new to render the psts new view, and use render_template method to verify that the correct template(view) is rendered.
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

# #3  expect the @post instance variable to be initialized by  PostsController#new. assigns gives us access to the @post variable, assigning it to :post.
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "POST create" do
# #4  the newly created object is persisted to the database
  #  expect that after PostsController#create is called with the parameters  {post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}, the count of Post instances (i.e. rows in the posts table) in the database will increase by one
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end

# #5  when create is POSTed to, we expect the newly created post to be assigned to @post.
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
    end

# #6  we expect to be redirected to the newly created post
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
    end
  end

  describe "GET show" do
    it "returns http success" do
# #16  pass {id: my_post.id} to show as a parameter. These parameters are passed to the  params hash
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
# #17  expect the response to return the show view using the  render_template matcher
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
# #18  expect the post to equal my_post because we call show with the id of  my_post
      expect(assigns(:post)).to eq(my_post)
    end
  end
end
