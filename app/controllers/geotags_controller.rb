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
  def index 
    @geotags = Geotag.all
    
    respond_to do |format|
     format.kml
    end 
  end
  
  def list
    @geotags = Geotag.surrounding_tags(params[:lat].to_f, params[:lng].to_f)
  
    respond_to do |format|
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
end
