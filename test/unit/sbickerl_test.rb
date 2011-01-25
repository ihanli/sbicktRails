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
  
  test "check user - sbickerl - geotag dependency" do
    isi = create_isi
    isi.save
    
    geotag1 = geotag2 = create_valid_geotag
    geotag1.save
    geotag2.save
    
    sbickerl2 = sbickerl1 = create_valid_sbickerl
    sbickerl2.user = sbickerl1.user = isi
    sbickerl1.geotag = geotag1
    sbickerl2.geotag = geotag2
    sbickerl1.save
    sbickerl2.save
    
    assert_equal isi.id, sbickerl1.user.id, "dependency problem between user and sbickerl1"
    assert_equal isi.id, sbickerl2.user.id, "dependency problem between user and sbickerl2"
    
    assert_equal geotag1.id, sbickerl1.geotag.id, "dependency problem between geotag1 and sbickerl1"
    assert_equal geotag2.id, sbickerl2.geotag.id, "dependency problem between geotag2 and sbickerl2"
    
    isi.destroy
    
    assert_nil Sbickerl.find_by_id(sbickerl1.id), "sbickerl1 wasn't deleted"
    assert_nil Sbickerl.find_by_id(sbickerl2.id), "sbickerl2 wasn't deleted"
    
    assert_nil Geotag.find_by_id(geotag1.id), "geotag1 wasn't deleted"
    assert_nil Geotag.find_by_id(geotag2.id), "geotag2 wasn't deleted"
  end
end
