require 'test_helper'

class SbickerlTest < ActiveSupport::TestCase
  
  test "valid sbickerl" do
    assert create_valid_sbickerl.valid?, "sbickerl no valid"
  end
  
  test "shouldn't save sbickerl with too long content" do
    sbickerl = create_valid_sbickerl
    sbickerl.content = (0...141).map{ ('a'..'z').to_a[rand(26)] }.join
    assert !sbickerl.save, "saved sbickerl with too long content"
  end
  
  test "shouldn't save sbickerl with too short content" do
    sbickerl = create_valid_sbickerl
    sbickerl.content = ""
    assert !sbickerl.save, "saved sbickerl with too short content"
  end
  
  test "valid visibilities" do
    assert Sbickerl.new(:content => "private", :visibility => "private").valid?, "visibility private not valid"
    assert Sbickerl.new(:content => "protected", :visibility => "protected").valid?, "visibility protected not valid"
    assert Sbickerl.new(:content => "public", :visibility => "public").valid?, "visibility public not valid"
  end
  
  test "shouldn't save sbickerl with invalid visibility" do
    assert !Sbickerl.new(:content => "invalid visibility", :visibility => "invalid").save, "saved sbickerl with invalid visibility"
  end
  
  test "check user dependency" do
    isi = create_isi
    isi.save
    
    sbickerl = create_valid_sbickerl
    sbickerl.user = isi
    sbickerl.save
    
    assert_equal isi.id, sbickerl.user.id
    
    isi.destroy
    
    assert_nil Sbickerl.find_by_id(sbickerl.id), "sbickerl wasn't deleted"
  end

end
