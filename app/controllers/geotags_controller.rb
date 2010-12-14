class GeotagsController < ApplicationController

  def index 
    @geotags = Geotag.all
  
    respond_to do |format|
	  #format.html
	  format.kml
	end
  end

end
