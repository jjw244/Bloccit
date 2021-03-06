require 'rails_helper'

RSpec.describe UsersController, type: :controller do

# #1  create a hash of attributes named new_user_attributes so we can use them easily throughout our spec
  let(:new_user_attributes) do
    {
        name: "BlocHead",
        email: "blochead@bloc.io",
        password: "blochead",
        password_confirmation: "blochead"
    }
  end

# #2  test the new action for HTTP success when issuing a GET (success = code 200)
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

# #3  est the create action for HTTP success when issuing a POST with  new_user_attributes set as the params hash
  describe "POST create" do
    it "returns an http redirect" do
    post :create, user: new_user_attributes
    expect(response).to have_http_status(:redirect)
  end

# #4  test that the database count on the users table increases by one when we issue a POST to create
    it "creates a new user" do
     expect{
       post :create, user: new_user_attributes
     }.to change(User, :count).by(1)
   end

# #5  test that we set user.name properly when creating a user
    it "sets user name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).name).to eq new_user_attributes[:name]
    end

# #6  test that we set user.email properly when creating a user
    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end

# #7  test that we set user.password properly when creating a user
    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end

# #8  test that we set user.password_confirmation properly when creating a user
    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end

    it "logs the user in after sign up" do
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq assigns(:user).id
    end
  end

  describe "not signed in" do
# #1  build a variable named factory_user using create(:user)
    let(:factory_user) { create(:user) }

    before do
      post :create, user: new_user_attributes
    end

# #2  write our standard tests for testing the show action
    it "returns http success" do
      get :show, {id: factory_user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: factory_user.id}
      expect(response).to render_template :show
    end

    it "assigns factory_user to @user" do
      get :show, {id: factory_user.id}
      expect(assigns(:user)).to eq(factory_user)
    end
  end
end
