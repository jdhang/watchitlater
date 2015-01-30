class SessionsController < ApplicationController
  before_action :require_login, only: [:dashboard, :watched_movies]

  def new
  end

  def create
    username = params[:username]
    password = params[:password]
    if user = User.authenticate(username, password)
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "You have successfully logged in."
    else
      flash[:error] = "Your username or password was incorrect."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out."
  end

  def dashboard
    @unwatched_movies = current_user.unwatched_movies
    respond_to do |format|
      format.html
      format.js
    end
  end

  def watched_movies
    @watched_movies = current_user.watched_movies
    respond_to do |format|
      format.js
    end
  end

end
