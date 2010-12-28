class GeotagsController < ApplicationController

  def index 
    @geotags = Geotag.all
  
    respond_to do |format|
	    format.html
	    format.kml
    end
  end
  
  def new
    @new_geotag = Geotag.new
  end

  def create
    @new_geotag = Geotag.new(params[:geotag])
      
    if @new_geotag.save
      redirect_to geotags_path
    end
  end
  
  def delete
    Geotag.find(params[:id]).destroy
    redirect_to geotags_path
  end
  
  def show
  end
end
