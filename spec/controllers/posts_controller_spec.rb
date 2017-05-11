require 'rails_helper'
# #4  add SessionsHelper so that we can use the create_session(user) method later in the spec
include SessionsHelper

# #6  RSpec created a test for PostsController.
 # type: :controller tells RSpec to treat the test as a controller test.
 # This allows us to simulate controller actions such as HTTP requests.
RSpec.describe PostsController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
# #12  create a parent topic named  my_topic
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
# #13  update how we create my_post so that it will belong to my_topic
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }

# #5  add a context for a guest (un-signed-in) user. Contexts organize tests based on the state of an object
  context "guest user" do
# #6  define the show tests, which allow guests to view posts in Bloccit
  describe "GET show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(assigns(:post)).to eq(my_post)
    end
  end

# #7  define tests for the other CRUD actions. We won't allow guests to access the  create, new, edit, update, or destroy actions
  describe "GET new" do
    it "returns http redirect" do
      get :new, topic_id: my_topic.id
# #8  expect guests to be redirected if they attempt to create, update, or delete a post
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "POST create" do
    it "returns http redirect" do
      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "GET edit" do
    it "returns http redirect" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "PUT update" do
    it "returns http redirect" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "DELETE destroy" do
    it "returns http redirect" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:redirect)
    end
  end
end

# #13  wrap our existing specs in a context so that they become our signed-in user specs
  context "signed-in user" do
    before do
      create_session(my_user)
    end

# #1  a new and unsaved Post object is created
    describe "GET new" do
      it "returns http success" do
# #18  update the get :new request to include the id of the parent topic
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
# #2  expect PostsController#new to render the psts new view, and use render_template method to verify that the correct template(view) is rendered.
      it "renders the #new view" do
# #19  update the get :new request to include the id of the parent topic
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end

# #3  expect the @post instance variable to be initialized by  PostsController#new. assigns gives us access to the @post variable, assigning it to :post.
      it "instantiates @post" do
# #20  update the get :new request to include the id of the parent topic
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end

    describe "POST create" do
# #4  the newly created object is persisted to the database
  #  expect that after PostsController#create is called with the parameters  {post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}, the count of Post instances (i.e. rows in the posts table) in the database will increase by one
      it "increases the number of Post by 1" do
# #21  update the post :create request to include the id of the parent topic
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end

# #5  when create is POSTed to, we expect the newly created post to be assigned to @post.
      it "assigns the new post to @post" do
# #22  update the post :create request to include the id of the parent topic
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      end

# #6  we expect to be redirected to the newly created post
      it "redirects to the new post" do
# #23  update the post :create request to include the id of the parent topic
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
# #24  redirect to  [my_topic, Post.last]
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end

    describe "GET show" do
      it "returns http success" do
# #15  update our get :show request to include the id of the parent topic
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
# #16  update our get :show request to include the id of the parent topic
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end

      it "assigns my_post to @post" do
# #17  update our get :show request to include the id of the parent topic
        get :show, topic_id: my_topic.id, id: my_post.id
# #18  expect the post to equal my_post because we call show with the id of  my_post
        expect(assigns(:post)).to eq(my_post)
      end
    end

    describe "GET edit" do
      it "returns http success" do
# #25  update the get :edit request to include the id of the parent topic
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
# #26  update the get :edit request to include the id of the parent topic
        get :edit, topic_id: my_topic.id, id: my_post.id
  # #1  expect the edit view to render when a post is edited.
        expect(response).to render_template :edit
      end

  # #2  test that edit assigns the correct post to be updated to @post
      it "assigns post to be updated to @post" do
# #27  update the get :edit request to include the id of the parent topic
        get :edit, topic_id: my_topic.id, id: my_post.id


        post_instance = assigns(:post)

        expect(post_instance.id).to eq my_post.id
        expect(post_instance.title).to eq my_post.title
        expect(post_instance.body).to eq my_post.body
      end
    end

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

# #28  update the put :update request to include the id of the parent topic
        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}

# #3  test that @post was updated with the title and body passed to update. We also test that @post's id was not changed
        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

# #29  update the put :update request to include the id of the parent topic
       put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
# #30  replace redirect_to my_post with redirect_to [my_topic, my_post] so that we'll be redirected to the posts show view after we nest posts
       expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "DELETE destroy" do
      it "deletes the post" do
# #31  update the delete :destroy request to include the id of the parent topic
        delete :destroy, topic_id: my_topic.id, id: my_post.id
# #6  search the database for a post with an id equal to my_post.id. This returns an Array
        count = Post.where({id: my_post.id}).size
        expect(count).to eq 0
      end

    it "redirects to topic show" do
# #32  update the delete :destroy request to include the id of the parent topic
        delete :destroy, topic_id: my_topic.id, id: my_post.id
# #33  we want to be redirected to the topics show view instead of the posts index view
        expect(response).to redirect_to my_topic
      end
    end
  end
end
