class MoviesController < ApplicationController
  before_action :set_movie, only: [:edit, :update, :destroy, :watched, :unwatch]
  before_action :require_login
  before_action :require_owner, only: [:edit, :update, :destroy, :watched, :unwatch]

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params.merge!(user: current_user))
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end

  def update
    @movie.update(movie_params)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end

  def watched
    @movie.update(watched: true)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end
  
  def unwatch
    @movie.update(watched: false)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.js
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:title)
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def require_owner
      message = "You are not allowed to do that."
      access_denied(message, dashboard_path) unless @movie.user == current_user
    end
end
