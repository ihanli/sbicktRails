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

class ApplicationController < ActionController::Base
#  protect_from_forgery
  
  def login_required
    if session[:user_id]
      return true
    end
    
    flash[:warning] = 'Please login to continue'
    session[:return_to] = request.fullpath
    redirect_to "/index.html#section_magauch"
    return false
  end

  def current_user
    User.find_by_id(session[:user_id])
  end
  
  def admin_rights_required
    return if current_user.admin?
    
    flash[:warning] = 'You don\'t have admin rights'
    redirect_to "/index.html#start"
    return false
  end
end
