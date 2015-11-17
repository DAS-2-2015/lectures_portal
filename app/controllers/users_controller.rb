class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def follow
    current_user = User.find(params[:current_user_id])

    respond_to do |format|
      if current_user.id != @user.id
        Follower.create panelist_id: @user.id, user_id: current_user.id

        format.html { redirect_to @user, notice: 'Você está seguindo este usuário.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to @user, notice: 'Você não pode seguir a si mesmo.' }
        format.json { render :show, status: :error, location: @user }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
