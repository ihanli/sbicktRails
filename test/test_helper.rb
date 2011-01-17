ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def create_isi
    return User.new(:nickname => "ihanli", :email => "ihanli@sbickt.com", :password => "braverAlex", :password_confirmation => "braverAlex")
  end

  def create_valid_sbickerl
    return Sbickerl.new(:content => "some content", :visibility => "private")
  end

  def create_valid_geotag
    return Geotag.new(:lat => 2.4, :lng => 3.6, :alt => 4.8)
  end
end
