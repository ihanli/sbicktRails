#################################################
#            s'bickt Android Client             #
# Bildungseinrichtung:  Fachhochschule Salzburg #
#         Studiengang:  MultiMediaTechnology    #
#               Zweck:  Qualifikationsprojekt   #
#################################################################################
#                                                                               #
# This is the client for the augmented reality and social community app s'bickt #
# Copyright Alexander Flatscher, Ismail Hanli                                   #
#                                                                               #
# This file is part of s'bickt.                                                 #
#                                                                               #
# S'bickt is free software: you can redistribute it and/or modify               #
# it under the terms of the GNU Affero General Public License as published by   #
# the Free Software Foundation, either version 3 of the License, or             #
# (at your option) any later version.                                           #
#                                                                               #
# S'bickt is distributed in the hope that it will be useful,                    #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 #
# GNU Affero General Public License for more details.                           #
#                                                                               #
# You should have received a copy of the GNU Affero General Public License      #
# along with s'bickt.  If not, see <http://www.gnu.org/licenses/>.              #
#################################################################################

class GeotagsController < ApplicationController 
  before_filter :login_required, :only => ["index", "new", "create", "destroy"]
  
  def index 
    if(params[:lat] && params[:lng])
      @geotags = Geotag.surrounding_tags(params[:lat].to_f, params[:lng].to_f)
    else
      @geotags = Geotag.all
    end
    
    respond_to do |format|
     format.kml
     format.html
    end 
  end
  
  def new
    @new_geotag = Geotag.new
    @new_sbickerl = Sbickerl.new
  end
  
  def create
    @new_geotag = Geotag.new(params[:geotag])
    @new_geotag.sbickerl = Sbickerl.new(params[:sbickerl])
    @new_geotag.sbickerl.user = User.find_by_id(session[:user_id])
      
    if @new_geotag.save
      flash[:message] = "successfully created geotag and sbickerl"
      redirect_to geotags_path
    end
  end
  
  def destroy
    Geotag.find(params[:id]).destroy
    redirect_to geotags_path
  end
  
  def count
    count = Geotag.count
    
    render :json => {:status => 'ok', :count => count}
  end
end
