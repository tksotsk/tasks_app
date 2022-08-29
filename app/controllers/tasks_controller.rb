class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:name, :content))
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(params.require(:task).permit(:name, :content))
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end
end
