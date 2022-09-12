class TasksController < ApplicationController
  def index
    @tasks=params[:sort_expired]?
      Task.sort_limit :
      Task.sort_created_at
      
      
      if  @tasks && params[:task]
        
        
        if params[:task][:name]!="" && params[:task][:status]==""
          @tasks=@tasks.name_search(params[:task][:name])
        end
        
        if params[:task][:name]=="" && params[:task][:status]!=""
          @tasks=@tasks.status_search(params[:task][:status])
        end
        
        if params[:task][:name]!="" && params[:task][:status]!=""
          @tasks=@tasks.name_search(params[:task][:name]).status_search(params[:task][:status])
        end
        # binding.pry
      
    end
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:name, :content, :limit, :status, :priority))
    
    
    
    if @task.save
      redirect_to task_path(@task.id)
      flash[:success] = "タスクを作成しました"
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
    
    if @task.update(params.require(:task).permit(:name, :content, :limit, :status, :priority))
      redirect_to tasks_path
      flash[:success] = "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
    flash[:success] = "タスクを削除しました"
  end

private




end

