class TasksController < ApplicationController
  def index
    @user=User.find(current_user.id)
    @tasks=Task.all
    @tasks=params[:sort_expired] && params[:sort_expired]=="true1"?
    @tasks.page(params[:page]).per(6).sort_limit :
    params[:sort_expired] && params[:sort_expired]=="true2"?
    @tasks.page(params[:page]).per(6).sort_priority :
    @tasks.page(params[:page]).per(6).sort_created_at
    
    
    if  @tasks && params[:task]
      @tasks=@tasks.name_search(params[:task][:name]) if params[:task][:name]!=""
      @tasks=@tasks.status_search(params[:task][:status]) if params[:task][:status]!=""
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:task][:label_id] }) if params[:task][:label_id]!=""
    end
  end
    
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(params.require(:task).permit(:name, :content, :limit, :status, :priority, { label_ids: [] }))
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
    
    if @task.update(params.require(:task).permit(:name, :content, :limit, :status, :priority, { label_ids: [] }))
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

