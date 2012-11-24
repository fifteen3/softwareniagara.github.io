require 'spec_helper'

describe Frontend::HomeController do
  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get :about
      response.should be_success
    end
  end

  describe "GET 'democamp'" do
    it "should be successful" do
      get :democamp
      response.should be_success
    end
  end
end