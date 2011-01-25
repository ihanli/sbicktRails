require 'test_helper'

class GeotagsControllerTest < ActionController::TestCase
  test "should create geotag with sbickerl and user" do
    isi = create_isi
    isi.save
    
    geotag = create_geotag
    sbickerl = create_sbickerl
    
    assert_difference('Geotag.count') do
      post :create, {:geotag => geotag.attributes, :sbickerl => sbickerl.attributes}, :user_id => isi.id
    end
    
    assert_equal "successfully created geotag and sbickerl", flash[:message], "flash message not equal"
    assert_redirected_to geotags_path, "redirect not correct"
    
    assert_equal Geotag.first.lat, geotag.lat, "lat not equal"
    assert_equal Geotag.first.lng, geotag.lng, "lng not equal"
    assert_equal Geotag.first.alt, geotag.alt, "alt not equal"
  end
  
  test "should delete geotag with sbickerl" do
    isi = create_isi
    isi.save
    
    geotag = create_geotag
    geotag.sbickerl = create_sbickerl
    geotag.sbickerl.user = isi
    
    geotag.save
    
    assert_difference('Geotag.count', -1) do
      delete :destroy, {:id => geotag.id}, :user_id => isi.id
    end
    
    assert_equal Sbickerl.all.count, 0
  end
  
end
