class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_lists_collection, only: [:new, :edit, :update]

  def index
    @tasks = current_user.tasks.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    list  = current_user.lists.find(task_params[:list_id])
    @task = list.tasks.new(task_params)

    if @task.save
      if request.xhr?
        render @task, status: :created
      else
        redirect_to @task, notice: 'Task was successfully created.'
      end
    else
      if request.xhr?
        render nothing: true, status: :unprocessable_entity
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      if request.xhr?
        render @task, status: :ok
      else
        redirect_to lists_url, notice: 'Task was successfully updated.'
      end
    else
      if request.xhr?
        render nothing: true, status: :unprocessable_entity
      else
        render :edit
      end
    end
  end

  def destroy
    @task.destroy

    if request.xhr?
      head :no_content, status: :ok
    else
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
    end
  end

  private
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_lists_collection
      @lists = current_user.lists
    end

    def task_params
      params.require(:task).permit(:list_id, :description, :done)
    end
end
