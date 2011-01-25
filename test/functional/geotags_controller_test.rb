require 'test_helper'

class GeotagsControllerTest < ActionController::TestCase
  test "should create geotag with sbickerl" do
    #isi = create_isi
    #isi.save
    assert_difference('Geotag.count') do
      post :create, {:geotag => create_valid_geotag.attributes, :sbickerl => create_valid_sbickerl.attributes}, :user_id => "1"
    end
    assert_equal "successfully created geotag and sbickerl", flash[:message]
    assert_redirected_to geotags_path
  end
end
