require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should create user" do
    admin = create_admin
    admin.save
    admin.make_admin!(true)
    
    assert_difference('User.count') do
      post :create, {:user => {:nickname => "ihanli", :email => "ihanli@gmail.com", :password => "braverAlex", :password_confirmation => "braverAlex"}}, :user_id => admin.id
    end
    assert_equal 'Signup successful', flash[:message]
    assert_redirected_to "/index.html#section_wo"
  end
  
  test "should login/logout user" do
    isi = create_isi
    isi.save
    
    post :login, {:nickname => isi.nickname, :password => isi.password}
    assert_equal "Login successful", flash[:message]
    assert_redirected_to "/index.html#section_wo"
    assert_equal isi.id, session[:user_id]
    
    get :logout
    assert_equal session[:user_id], nil
    assert_equal flash[:message], 'Logged out'
    assert_redirected_to "/index.html#section_wurzeln"
  end
  
  test "shouldn't login with invalid nickname or password" do
    isi = create_isi
    isi.save
    
    post :login, {:nickname => 'invalid', :password => isi.password}
    assert_redirected_to "/index.html#section_magauch"
    assert_not_equal isi.id, session[:user_id]
    assert_equal "Login unsuccessful", flash[:warning]

    post :login, {:nickname => isi.nickname, :password => 'invalid'}
    assert_redirected_to "/index.html#section_magauch"
    assert_not_equal isi.id, session[:user_id]
    assert_equal "Login unsuccessful", flash[:warning]
  end
  
  test "should destroy user with sbickerl" do
    isi = create_isi
    isi.save
    
    geotag = create_geotag
    geotag.sbickerl = create_sbickerl
    geotag.sbickerl.user = isi
    
    assert geotag.save
    
    assert_difference('User.count', -1) do
      delete :destroy, nil, :user_id => isi.id
    end
    
    assert_equal Geotag.all.count, 0
    assert_equal Sbickerl.all.count, 0
    
    assert_equal 'Your account was deleted', flash[:message]
  end
  
  test "should destroy other user as admin" do
    isi = create_isi
    isi.save
    
    admin = create_admin
    admin.save
    admin.make_admin!(true)
    
    assert_difference('User.count', -1) do
      delete :destroy, {:id => isi.id}, :user_id => admin.id
    end
    
    assert_not_nil User.find_by_id(admin.id)
    assert_nil User.find_by_id(isi.id)
  end
  
  
end
