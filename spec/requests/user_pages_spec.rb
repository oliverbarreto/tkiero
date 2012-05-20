#User Pages = Handles Sign Up Form
require 'spec_helper'

describe "User pages" do
  let(:base_title) { "tKiero App" }
  subject { page }

  # Page Content 
  describe "Signup page" do

    before { visit signup_path }

    it { should have_content('Build One IDeas') }
    it { should have_selector('h2',    text: "#{base_title}") }
    it { should have_selector('title', text: full_title('')) }
    it { should have_selector 'title', text: '| Sign Up' }
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