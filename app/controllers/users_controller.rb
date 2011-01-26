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

class UsersController < ApplicationController
  before_filter :login_required, :only => ["show", "logout, destroy"]
  before_filter :admin_rights_required, :only => ["index", "create"]
    
  def index
    @users = User.all
  end
  
  def new
    @new_user = User.new
  end
  
  def create
    @new_user = User.new(params[:user])
    
    if @new_user.save
      session[:user_id] = User.authenticate(@new_user.nickname, @new_user.password)
      flash[:message] = "Signup successful"
      redirect_to "/index.html#section_wo"
    else
      flash[:warning] = "Signup unsuccessful"
      redirect_to "/index.html#section_magauch"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def login
    if session[:user_id] = User.authenticate(params[:nickname], params[:password])
      flash[:message] = "Login successful"
      redirect_to "/index.html#section_wo"
    else
      flash[:warning] = "Login unsuccessful"
      redirect_to "/index.html#section_magauch"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:message] = 'Logged out'
    redirect_to "/index.html#section_wurzeln"
  end

  def destroy
    if current_user.admin?
      if User.find_by_id(params[:id]).destroy
        flash[:message] = 'User destroyed'
        redirect_to :action => :index
      else
        flash[:warning] = 'couldn\'t destroy user'
      end
    else
      if current_user.destroy
        flash[:message] = 'Your account was deleted'
        redirect_to "/index.html#start"
      else
        flash[:warning] = 'We weren\'t able to delete your account'
      end
    end
  end
end
