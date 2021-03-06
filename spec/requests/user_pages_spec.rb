#User Pages = Handles Sign Up Form
require 'spec_helper'

describe "User pages" do
  let(:base_title) { "tKiero App" }
  subject { page }

  # Sign Up - Page Content 
  describe "Signup page" do

    before { visit signup_path }
    let(:submit) { "Create your Account" }
  
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
        it { should have_link('Log Out') }
      end
    end
  end

  # User Wall Page Content
  describe "User Wall Page" do

    # Code to make a user variable from ActiveRecord:Test:Environment with FactoryGirl gem 
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_content('Build One IDeas') }
    it { should have_selector('h2',    text: user.name) }
    it { should have_selector('title', text: full_title('')) }
    it { should have_selector 'title', text: "| #{user.name}" }
  end


  # Test Edit Users Form - My Settings User Profile 
  describe "edit - My Settings User Profile" do
    
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h2', text: 'tKiero App - Update Your User Profile Settings') }
      it { should have_selector('title', text: 'Edit User') }
      it { should have_selector('label', text: 'Email') }
      it { should have_selector('label', text: 'Password') }
      it { should have_selector('label', text: 'Password confirmation') }
      it { should have_link('Change your Gravatar Image', href: 'http://gravatar.com/emails') }
    end

    # Test for Invalid Information 
    describe "with invalid information" do
      before { click_button 'Save Changes' }
      it { should have_content('error') }
    end


    # Test for Valid Information 
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
    
      before do
        fill_in 'Name',             with: new_name
        fill_in 'Email',            with: new_email
        fill_in 'Password',         with: user.password
        fill_in 'Password confirmation', with: user.password
        click_button 'Save Changes'
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Log Out', href: logout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end

    
  end

end