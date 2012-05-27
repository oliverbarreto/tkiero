# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe User do

  # Creates a stud user model for testing purposes
  before do
    #We need a valid: name, eMail and a password to create hash and salt on create action 
    @user = User.new(name: "User", email: "user@example.com", password: "12121212", password_confirmation: "12121212") 
  end
  
  subject { @user }
  
  # The Model should respond to the following fields
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_salt) } 
  it { should respond_to(:password_hash) }
  it { should respond_to(:remember_token) }
  it { should be_valid }
  
  
    
  #  Test invalid cases: no name
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  #Test invalid cases: name MAX Length
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  # Test invalid cases: eMail format
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  #Test valid cases: eMail format
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
  
  #Test eMail Uniqueness
    describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  # Password
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when a password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 3}
    it { should_not be_valid}
  end
  
  describe "with a password that's too long" do
    before { @user.password = @user.password_confirmation = "a" * 102}
    it { should_not be_valid }
  end  
  # #This can only happen on the console
  # describe "when password confirmation is nil" do
    # before { @user.password_confirmation = nil }
    # it { should_not be_valid }
  # end
    
  # Authenticate Users Validations
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.authenticate(@user.email, @user.password) }
    #user = User.authenticate(params[:email], params[:password])

    # Case of Valid Password
    describe "with valid password" do
      #it { should == found_user.authenticate(@user.email, @user.password) }
      it { should be_valid }
    end

    # Case of Invalid Password
    describe "with invalid password" do
      # Creates a duplicate of our stud :found_user test variable to verify that test fails because it gets the same user
      # In our User.authenticate method we return "nil" for not valid users
      #let(:user_for_invalid_password) { nil }
      let(:user_for_invalid_password) { User.authenticate(@user.email, "@user.password") }
      
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "" do
    
    
  end

end
