require 'spec_helper'

describe Frontend::NewsletterController do
  describe "GET 'new'" do
    before (:each) do
      @email = Email.new
    end

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should create a new email" do
      Email.should_receive(:new).and_return(@email)
      get :new
    end
  end

  describe "POST 'create'" do
    before (:each) do
      Email.stub!(:new).and_return(@email = mock_model(Email, save: true))
    end

    def do_create
      post :create, email: {
          name: 'Johnny Appleseed',
          email: 'johnny.appleseed@gmail.com',
          website: 'http://www.johnny.com',
          twitter_handle: 'appleseed',
          interests: 'Computers, Floppy Disks',
          location: 'Niagara Falls'
        }
    end

    it "should create the email" do
      Email.should_receive(:new).with(
          'name' => 'Johnny Appleseed',
          'email' => 'johnny.appleseed@gmail.com',
          'website' => 'http://www.johnny.com',
          'twitter_handle' => 'appleseed',
          'interests' => 'Computers, Floppy Disks',
          'location' => 'Niagara Falls'
        ).and_return(@email)
      do_create
    end

    it "should save the email" do
      Email.should_receive(:save).and_return(true)
      do_create
    end

    it "should be redirect" do
      do_create
      response.should be_redirect
    end
  end
end