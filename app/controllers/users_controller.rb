class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :require_login, only: [:edit, :update]
  before_action :require_owner, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "You have successfully registered."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_path, notice: "You have successfully updated."
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_owner
      message = 'You are not allowed to do that.'
      access_denied(message, dashboard_path) if @user != current_user
    end
end
