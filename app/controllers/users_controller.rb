class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new,:create]
  def new
    @user=User.new
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def show
    @user=User.find(params[:id])
    @tasks=Task.where(user_id: params[:id])
    redirect_to tasks_path if @user.id != current_user.id && current_user.admin == false
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
