class UsersController < ApplicationController
  before_filter :login_required, :only => ["show", "logout"]
    
  def index
    @users = User.all
  end
  
  def new
    @new_user = User.new
  end
  
  def create
    @new_user = User.new(params[:user])
    
    if @new_user.save
      session[:user] = User.authenticate(@new_user.nickname, @new_user.password)
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
    if session[:user] = User.authenticate(params[:nickname], params[:password])
      flash[:message] = "Login successful"
      redirect_to "/index.html#section_wo"
    else
      flash[:warning] = "Login unsuccessful"
      redirect_to "/index.html#section_magauch"
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to "/index.html#section_wurzeln"
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => :index
  end
end
