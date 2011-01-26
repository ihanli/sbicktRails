require 'test_helper'

class GeotagTest < ActiveSupport::TestCase
  
  test "valid geotag" do
    assert create_geotag.valid?, "sbickerl no valid"
  end
  
  test "shouldn't save geotag without lat, lng or alt" do
    assert !Geotag.new(:lng => 1.5, :alt => 1.5).save, "saved geotag without lat"
    assert !Geotag.new(:lat => 1.5, :alt => 1.5).save, "saved geotag without lng"
    assert !Geotag.new(:lat => 1.5, :lng => 1.5).save, "saved geotag without alt"
  end
  
  test "check geotag - sbickerl dependency" do
    geotag = create_geotag
    geotag.sbickerl = sbickerl = create_sbickerl
    
    sbickerl.save
    geotag.save
    
    assert_equal geotag.sbickerl.id, sbickerl.id, "dependency problem between geotag and sbickerl"
    
    sbickerl.destroy
    
    assert_nil Geotag.find_by_id(geotag.id), "geotag wasn't deleted"
  end
  
  test "get surrounding geotags" do
    geotag = Geotag.new(:lat => 45.0, :lng => 12.0, :alt => 480.0)
    geotag.save
    
    Geotag.surrounding_tags(44.0, 11.0).each { |g| assert_nil g, "got a geotag which is too far away" }
    Geotag.surrounding_tags(45.3, 12.3).each { |g| assert_not_nil g, "didn't get surrounding geotag" }
  end
end
