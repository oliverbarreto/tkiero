#User Pages = Handles Sign Up Form
require 'spec_helper'

describe "User pages" do
  let(:base_title) { "tKiero App" }
  subject { page }

  # Page Content 
  describe "Signup page" do

    before { visit signup_path }
    let(:submit) { "Create your account..." }
  
    describe "Singup page correct content" do
      it { should have_content('Build One IDeas') }
      it { should have_selector('h2',    text: "#{base_title}") }
      it { should have_selector('title', text: full_title('')) }
      it { should have_selector 'title', text: '| Sign Up' }
    end
    
    # Test Invalid information - Send an empty form
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    describe "after submission" do
      before { click_button submit }

      it { should have_selector 'title', text: '| Sign Up' }
      it { should have_content('error') }
    end

    # Test Valid information - Send an correct form
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
    
    
  end

  # Page Content
  describe "Profile page" do

    # Code to make a user variable from ActiveRecord:Test:Environment with FactoryGirl gem 
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_content('Build One IDeas') }
    it { should have_selector('h2',    text: user.name) }
    it { should have_selector('title', text: full_title('')) }
    it { should have_selector 'title', text: "| #{user.name}" }
  end

end