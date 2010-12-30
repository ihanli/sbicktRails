xml.instruct!
xml.kml(:xmlns => "http://www.opengis.net/kml/2.2") do

  @geotags.each do |geotag|
    geotag.sbickerls.each do |sbickerl|
      xml.Placemark (:id => geotag.id.to_s, :visibility => sbickerl.visibility.to_s) {
        xml.name(sbickerl.owner.to_s)
	    xml.description(sbickerl.content.to_s)
	    xml.Point {
	      xml.coordinates(geotag.x.to_s + "," + geotag.y.to_s + ","  + geotag.z.to_s)
	    }
      }
    end
  end
end