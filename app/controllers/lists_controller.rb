class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = scoped_lists.includes(:user, :tasks)
    @task = Task.new
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = current_user.lists.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_path, notice: 'List was successfully created. You can now add tasks to this list.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_path, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /lists/1/favorite
  def favorite
    list = List.publicly_accessible.find(params[:list_id])
    @favorite_list = list.favorite_lists.new(user: current_user)

    respond_to do |format|
      if @favorite_list.save
        format.html { redirect_to lists_url(list_scope: 'public'), notice: 'List was successfully favorited.' }
        format.js   { render :template => 'lists/toggle_favorite.js.erb' }
      else
        format.html { redirect_to lists_url(list_scope: 'public') }
        format.js   {  }
      end
    end
  end

  # DELETE /lists/1/unfavorite
  def unfavorite
    list = List.publicly_accessible.find(params[:list_id])
    @favorite_list = list.favorite_lists.find_by(user: current_user)

    @favorite_list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully unfavorited.' }
      format.js   { render :template => 'lists/toggle_favorite.js.erb' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = current_user.lists.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:subject, :public_access)
    end

    def scoped_lists
      return List.publicly_accessible.where.not(user: current_user) if params[:list_scope] == 'public'
      return current_user.favorited_lists if params[:list_scope] == 'favorited'
      return current_user.lists
    end
end
