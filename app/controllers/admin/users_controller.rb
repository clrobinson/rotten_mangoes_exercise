class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

protected
  
  def restrict_admin_access
    @current_user = User.find(session[:user_id]) if session[:user_id]
    if (@current_user == nil) || (@current_user.admin != true)
      redirect_to movies_path
    end
  end

end
