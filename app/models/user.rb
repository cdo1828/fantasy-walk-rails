class User < ActiveRecord::Base
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

    
    validates :email, presence:true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence:true, length: { minimum: 6 }
    

    def has_password?(submitted_password)
        self.password == submitted_password
    end

    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
    end
end