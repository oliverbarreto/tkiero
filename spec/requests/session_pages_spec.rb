#User Pages = Handles Log In & Log Out Form
require 'spec_helper'

describe "SessionPages" do
  let(:base_title) { "tKiero App" }
  subject { page }

  # Log In Page
  describe "Log In page" do

    before { visit login_path }


    # Test basic Page Content
    describe "Right Content in Login Page" do
      it { should have_content('Build One IDeas') }
      it { should have_selector('h2',    text: "#{base_title}") }
      it { should have_selector('title', text: full_title('')) }
      it { should have_selector 'title', text: '| Log In' }
    end
    
    # Test Log-In with Invalid Information
    describe "with invalid information" do
      before { click_button "Log In" }

      it { should have_selector('title', text: 'Log In') }
      it { should have_selector('div.alert', text: 'Invalid eMail or Password') }
      it { should have_link('Log In', href: login_path) }
      it { should have_link('Sign Up', href: signup_path) }

      # Validate that when we get an error, we don't have the flash message repited on other pages
      describe "after visiting another page" do
        before { click_link "logo" }
        it { should_not have_selector('div.alert', text: 'Invalid eMail or Password') }
      end
    end
  
    # Test Log-In with Valid Information
    describe "with Valid Information" do
      let(:user) { FactoryGirl.create(:user) }
      #before { sign_in user }

      before do
        fill_in "email",    with: user.email
        fill_in "password", with: user.password
        click_button "Log In"
      end

      it { should have_link('Log Out', href: logout_path) }
      it { should_not have_link('Log In', href: login_path) }

      describe "followed by signout" do
        before { click_link "Log Out" }
        it { should have_link('Log In') }
      end
      
      #TODO: Page should have the name of the user
      it { should have_selector('title', text: user.name) }
      #TODO: Links on the profile drop-down button link on the Nav-Bar Menu  
      it { should have_link('My Wall', href: user_path(user)) }
      it { should have_link('My Settings', href: edit_user_path(user)) }
      it { should have_link('Help', href: help_path) }
      it { should have_link('Log Out', href: logout_path) }
      
    end
  end
end
