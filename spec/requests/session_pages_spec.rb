#User Pages = Handles Log In & Log Out Form
require 'spec_helper'

describe "SessionPages" do
  let(:base_title) { "tKiero App" }
  subject { page }

  #Log In Page
  describe "Log In page" do

    before { visit login_path }

    it { should have_content('Build One IDeas') }
    it { should have_selector('h2',    text: "#{base_title}") }
    it { should have_selector('title', text: full_title('')) }
    it { should have_selector 'title', text: '| Log In' }
  end

end
