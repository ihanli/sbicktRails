xml.instruct!
xml.kml(:xmlns => "http://www.opengis.net/kml/2.2") do
  xml.Document do
    @geotags.each do |geotag|
      geotag.sbickerls.each do |sbickerl|
        xml.Placemark(:id => geotag.id.to_s, :visibility => sbickerl.visibility.to_s) {
          xml.name(sbickerl.owner.to_s)
	      xml.description(sbickerl.content.to_s)
	      xml.Point {
	        xml.coordinates(geotag.lng.to_s + "," + geotag.lat.to_s + ","  + geotag.alt.to_s)
	     }
        }
      end
    end
  end
end