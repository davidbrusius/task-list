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

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
        format.js   { }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js   { render status: 500, nothing: true }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to lists_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
        format.js   { }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { }
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
