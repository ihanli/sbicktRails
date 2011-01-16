#################################################
#            s'bickt Android Client             #
# Bildungseinrichtung:  Fachhochschule Salzburg #
#         Studiengang:  MultiMediaTechnology    #
#               Zweck:  Qualifikationsprojekt   #
#################################################################################
#                                                                               #
# This is the client for the augmented reality and social community app s'bickt #
# Copyright Alexander Flatscher, Ismail Hanli                                   #
#                                                                               #
# This file is part of s'bickt.                                                 #
#                                                                               #
# S'bickt is free software: you can redistribute it and/or modify               #
# it under the terms of the GNU Affero General Public License as published by   #
# the Free Software Foundation, either version 3 of the License, or             #
# (at your option) any later version.                                           #
#                                                                               #
# S'bickt is distributed in the hope that it will be useful,                    #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 #
# GNU Affero General Public License for more details.                           #
#                                                                               #
# You should have received a copy of the GNU Affero General Public License      #
# along with s'bickt.  If not, see <http://www.gnu.org/licenses/>.              #
#################################################################################

require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :sbickerls
  
  validates_length_of :nickname, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_uniqueness_of :nickname, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  

  attr_accessible :nickname, :firstname, :lastname, :email, :password

  attr_accessor :password
  
  def self.authenticate(nickname, pass)
    u = find(:first, :conditions => ["nickname = ?", nickname])
    
    return unless u
    
    if User.encrypt(pass, u.salt) == u.hashed_password
      return u
    end
    
    return nil
  end  
  
  def password=(pass)
    @password = pass
    
    if !self.salt?
      self.salt = User.random_string(10)
    end

    self.hashed_password = User.encrypt(@password, self.salt)
  end
  
  def self.admin?()
    return self.admin
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
