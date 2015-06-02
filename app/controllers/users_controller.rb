class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    unless params[:offset]
      @users ||= User.all
    else
      if params[:limit]
        @users = User.limit(params[:limit]).offset(params[:offset])
      else
        @users = User.offset(params[:offset])
      end
    end
    respond_to do |format|
      format.html
      format.json 
      # format.json{ render plain: "OK" if params[:acao] } 
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new

    # binding.pry

    if request.xhr?
      render layout: false and return
      # render json: @user
      # render json: { usuario: @user }
    end

    # HTTP request rendering
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /users/1/edit
  def edit
    if request.xhr?
      render layout: false
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          if request.xhr?
            @user = User.new
            flash[:notice] = "User was successfully created."
            flash.discard :notice
            render :new, layout: false
          else
            redirect_to @user, notice: 'User was successfully created.'
          end
        end
        format.json { render :show, status: :created, location: @user }
      else
        format.html do 
          if request.xhr?
            render :new, layout: false
          else
            render :new
          end
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    respond_to do |format|
      if @user.update(user_params)
        format.html do
          if request.xhr?
            flash[:notice] = "User was successfully updated."
            # elimina flash no final da ação
            flash.discard :notice
            render :edit
          else
            redirect_to @user, notice: 'User was successfully updated.'
          end
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html do 
          if request.xhr?
            render :edit, layout: false
          else
            render :edit
          end
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        if request.xhr?
          render nothing: true
        else
          redirect_to users_url, notice: 'User was successfully destroyed.'
        end
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nome, :sobrenome, :email, :telefone, :password, :password_confirmation)
    end
end
