# == Schema Information
#
# Table name: users
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  email          :string(255)
#  password_hash  :string(255)
#  password_salt  :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  auth_token     :string(255)
#  remember_token :string(255)
#

class User < ActiveRecord::Base
    #only allow access to this fields from the internet 
    attr_accessible :name, :email, :password, :password_confirmation

    # Creates an instance variable for :password submitted by the HTML Form, and validate password_confirmation 
    attr_accessor :password
    validates_confirmation_of :password
    
    #Calls encrypt_password method to encrypt before saving the user model    
    before_save :encrypt_password
    
    # Downloadcase before save email to avoid possible eMail duplication issues   
    # before_save { |user| user.email = email.downcase }
     before_create :downcase_eMail

    
    #Validation policy for users: name, password and eMail
    validates :name, presence: true, 
                     length: { minimum: 1, maximum: 50 }
    
    validates :password, presence: true,
                          :on => :create,
                          length: { minimum: 6, maximum: 100 }

    
    #validates_presence_of :email
    #validates_uniqueness_of :email
    #TODO - Must improve the validating eMail Regex for 'oli.@gmail..com'
    validates :email, presence: true, 
                      length: { minimum: 3, maximum: 100 },
                      #format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      #uniqueness: true
                      uniqueness: { case_sensitive: false }
  
    # Creates a remember_token for cookie validation
    before_save :create_remember_token

    # Method to download case of eMail before create model method 
    #private
    def downcase_eMail
      self.email.downcase!
    end
    
  
    # Method to Authenticate users on controller 
    def self.authenticate(email, password)
      user = find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user 
      else
        nil
      end
    end
    
    # Method to encrypt users' passwords creating two db fields: pw_salt & pw_hash  
    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
    
    private
    
      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
      
    
end
