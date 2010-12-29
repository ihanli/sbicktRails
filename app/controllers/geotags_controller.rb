class GeotagsController < ApplicationController

  def index 
    @geotags = Geotag.all
    @sbickerls = Sbickerl.all
  
    respond_to do |format|
	    format.html
	    format.kml
    end
  end
  
  def new
    @new_geotag = Geotag.new
    @new_sbickerl = Sbickerl.new
  end

  def create
    @new_geotag = Geotag.new(params[:geotag])
    @new_sbickerl = @new_geotag.sbickerls.build(params[:sbickerl])
      
    if @new_geotag.save
      redirect_to geotags_path
    end
  end
  
  def destroy
    Geotag.find(params[:id]).destroy
    redirect_to geotags_path
  end
  
  def show
  end
end
