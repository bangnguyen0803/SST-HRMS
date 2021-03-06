require 'spec_helper'

describe Admin::UsersController do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    admin.confirm!
    user.confirm!
    sign_in(admin)
  end

  it "initial page load should load all users " do
    get :index

    assigns(:users).should include(user)
    assigns(:users).should include(admin)
  end

  it "search without search params should return all users" do
    search_params = { email: "", first_name: "", last_name: "" }
    get :search, search_params

    assigns(:users).should include(user)
    assigns(:users).should include(admin)
  end

  it "search with admin email should return only admin user" do
    search_params = { email: "admin@example.com", first_name: "", last_name: "" }
    get :search, search_params

    assigns(:users).should include(admin)
    assigns(:users).should_not include(user)
  end
  
  it "should deliver the welcome email" do
    UserMailer.should_receive(:welcome_to_strongtie).and_return(double("UserMailer", :deliver => true))

    post :create, :user => {:email => "user@user.com", :password => "password", :password_confirmation => "password"}
  end
end
