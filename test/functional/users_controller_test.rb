require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:nickname => "ihanli", :email => "ihanli@gmail.com", :password => "braverAlex", :password_confirmation => "braverAlex"}
    end
    assert_equal 'Signup successful', flash[:message]
    assert_redirected_to "/index.html#section_wo"
  end
  
  test "should login/logout user" do
    isi = create_isi
    isi.save
    
    post :login, :nickname => isi.nickname, :password => isi.password
    assert_equal "Login successful", flash[:message]
    assert_redirected_to "/index.html#section_wo"
    assert_equal isi.id, session[:user]
    
    get :logout
    assert_equal session[:user], nil
    assert_equal flash[:message], 'Logged out'
    assert_redirected_to "/index.html#section_wurzeln"
  end
  
  test "shouldn't login with invalid nickname or password" do
    isi = create_isi
    isi.save
    
    post :login, :nickname => 'invalid', :password => isi.password
    assert_redirected_to "/index.html#section_magauch"
    assert_not_equal isi.id, session[:user]
    assert_equal "Login unsuccessful", flash[:warning]

    post :login, :nickname => isi.nickname, :password => 'invalid'
    assert_redirected_to "/index.html#section_magauch"
    assert_not_equal isi.id, session[:user]
    assert_equal "Login unsuccessful", flash[:warning]
  end
  
end
