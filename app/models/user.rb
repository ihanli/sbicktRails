require 'digest/sha1'

class User < ActiveRecord::Base
  validates_length_of :nickname, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_uniqueness_of :nickname, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  

  attr_protected :id, :salt

  attr_accessor :password, :password_confirmation
  
  def self.authenticate(nickname, pass)
    u = find(:first, :conditions => ["nickname = ?", nickname])
      
    if u.nil?
      return nil
    end
    
    if User.encrypt(pass, u.salt) == u.hashed_password
      return u
    end
    
    nil
  end  
  
  def password=(pass)
    @password = pass
    
    if !self.salt?
      self.salt = User.random_string(10)
    end

    self.hashed_password = User.encrypt(@password, self.salt)
  end

  protected
  
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
  
  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    
    return newpass
  end
end
