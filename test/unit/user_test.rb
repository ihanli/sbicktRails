require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "save new user" do
    counted = User.count
    create_isi.save
    assert_equal counted + 1, User.count, "user wasn't saved"
  end
  
  test "shouldn't save user with too short nickname" do
    user = create_isi
    user.nickname = "is"
    assert !user.save, "saved user with too short nickname"
  end

  test "shouldn't save user with too long nickname" do
    user = create_isi
    user.nickname = "abcdefghijklmnopqrstuvwxyzabcdefghijklmno"
    assert !user.save, "saved user with too long nickname"
  end 
   
  test "shouldn't save user with too short password" do
    user = create_isi
    user.password = "brav"
    user.password_confirmation = "brav"
    assert !user.save, "saved user with too short password"
  end
   
  test "shouldn't save user with too long password" do
    user = create_isi
    user.password = "abcdefghijklmnopqrstuvwxyzabcdefghijklmno"
    user.password_confirmation = "abcdefghijklmnopqrstuvwxyzabcdefghijklmno"
    assert !user.save, "saved user with too long password"
  end
  
  test "shouldn't save new user with pre-existing nickname" do
    create_isi.save
    user = create_isi
    user.email = "ismailhanli@sbickt.com"
    assert !user.save, "saved user with pre-existing nickname"
  end
  
  test "shouldn't save new user with pre-existing email" do
    create_isi.save
    user = create_isi
    user.nickname = "ismailhanli"
    assert !user.save, "saved user with pre-existing email"
  end
  
  test "shouldn't save user with wrong password confirmation" do
    user = create_isi
    user.password = "braverAlex"
    user.password_confirmation = "boeserAlex"
    assert !user.save, "saved user with wrong password confirmation"
  end
  
  test "shouldn't save user with wrong email format" do
    user = create_isi
    user.email = "blub.com"
    assert !user.save, "saved user with wrong email format"
  end
  
  test "authenticate a user" do
    isi = create_isi
    isi.save
    user = User.find(:first, :conditions => ["nickname = ?", isi.nickname])
    user_id = User.authenticate(isi.nickname, isi.password)
    assert_equal user.id, user_id, "user wasn't authenticated"
  end
  
  test "shouldn't authenticate a user with a wrong password" do
    user = create_isi
    user.save
    assert_nil User.authenticate(user.nickname, user.password + "distortion"), "authenticated a user with a wrong password"
  end
  
  test "shouldn't authenticate a nonexistent user" do
    user = create_isi
    assert_nil User.authenticate(user.nickname, user.password), "authenticated a nonexistent user"
  end
  
  test "user password should be encrypted with salt" do
    isi = create_isi
    pwd = isi.password
    isi.save
    savedUser = User.find(:first, :conditions => ["nickname = ?", isi.nickname])
    assert_not_nil savedUser.salt, "salt wasn't generated"
    assert_equal User.encrypt(pwd, savedUser.salt), savedUser.hashed_password, "passwords are encrypted differently"
  end
end
