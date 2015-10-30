class User < ActiveRecord::Base
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

    validates :email, presence:true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence:true, length: { minimum: 6 }
    

 def self.authenticate(email)
    user = User.find_by_email(email)
    if user 
    # && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end