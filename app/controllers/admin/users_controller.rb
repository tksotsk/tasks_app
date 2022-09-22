class Admin::UsersController < ApplicationController
  def index
    if current_user.admin==true
      @users=User.includes(:tasks)
      @form_id = params[:form]?params[:form]:0
      
    else
      flash[:error] = "管理者以外はユーザー管理画面にアクセスできません"
      redirect_to tasks_path
    end
  end

  def new
    @user = User.new
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Object successfully created"
      redirect_to admin_users_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.last_one_admin?
        flash[:error] = "管理者がいなくなるので編集できません"
        redirect_to admin_users_path
      elsif @user.update(user_params)
        flash[:success] = "User was successfully updated"
        redirect_to admin_users_path
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.last_one_admin?
      flash[:error] = "管理者がいなくなるので削除できません"
      redirect_to admin_users_path
    else
      Task.where(user_id: params[:id]).delete_all
      if @user.destroy
        flash[:success] = 'User was successfully deleted.'
        redirect_to admin_users_path
      else
        flash[:error] = 'Something went wrong'
        redirect_to admin_users_path
      end
    end
  end
  

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
