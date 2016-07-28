class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_lists_collection, only: [:new, :edit, :update]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
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

  # PATCH/PUT /tasks/1
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

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy

    if request.xhr?
      head :no_content, status: :ok
    else
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_lists_collection
      @lists = current_user.lists
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:list_id, :description, :done)
    end
end
