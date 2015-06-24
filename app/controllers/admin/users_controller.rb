class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def index
    max_per_page = 10
    num_users = User.count
    @max_pages = num_users / max_per_page
    @max_pages += 1 if (num_users % max_per_page) > 0
    session[:admin_users_page] ||= 1
    session[:admin_users_page] = 1 if session[:admin_users_page] < 1
    session[:admin_users_page] = @max_pages if session[:admin_users_page] > @max_pages
    @users_page = User.page(session[:admin_users_page]).per(max_per_page)
  end

  def next_page
    session[:admin_users_page] += 1
    redirect_to admin_users_path
  end

  def prev_page
    session[:admin_users_page] -= 1
    redirect_to admin_users_path
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
