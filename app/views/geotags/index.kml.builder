xml.instruct!
xml.kml(:xmlns => "http://www.opengis.net/kml/2.2") do

  @geotags.each do |geotag|
    xml.Placemark {
      xml.name("test")
	  xml.description("testing builder in rails")
	  xml.Point {
	    xml.coordinates(geotag.x.to_s + "," + geotag.y.to_s + ","  + geotag.z.to_s)
	  }
    }
  end
end