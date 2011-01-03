<!--            s'bickt Android Client             -->
<!-- Bildungseinrichtung:  Fachhochschule Salzburg -->
<!--         Studiengang:  MultiMediaTechnology    -->
<!--               Zweck:  Qualifikationsprojekt   -->

<!-- This is the client for the augmented reality and social community app s'bickt -->
<!-- Copyright Alexander Flatscher, Ismail Hanli                                   -->

<!-- This file is part of s'bickt.                                                 -->

<!-- S'bickt is free software: you can redistribute it and/or modify               -->
<!-- it under the terms of the GNU Affero General Public License as published by   -->
<!-- the Free Software Foundation, either version 3 of the License, or             -->
<!-- (at your option) any later version.                                           -->

<!-- S'bickt is distributed in the hope that it will be useful,                    -->
<!-- but WITHOUT ANY WARRANTY; without even the implied warranty of                -->
<!-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 -->
<!-- GNU Affero General Public License for more details.                           -->

<!-- You should have received a copy of the GNU Affero General Public License      -->
<!-- along with s'bickt.  If not, see <http://www.gnu.org/licenses/>.              -->

xml.instruct!
xml.kml(:xmlns => "http://www.opengis.net/kml/2.2") do
  @geotags.each do |geotag|
    geotag.sbickerls.each do |sbickerl|
      xml.Placemark(:id => geotag.id.to_s, :visibility => sbickerl.visibility.to_s) {
        xml.name(sbickerl.owner.to_s)
	    xml.description(sbickerl.content.to_s)
	    xml.Point {
	      xml.coordinates(geotag.x.to_s + "," + geotag.y.to_s + ","  + geotag.z.to_s)
	    }
      }
    end
  end
end