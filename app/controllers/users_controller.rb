class UsersController < ApplicationController
  before_action :set_user, only: [:show, :notifications, :follow]

  # GET /users
  # GET /users.json
  def index
    if params[:search]
      @users = User.search(params[:search])
    else
      speakers = []
      Lecture.find_each do |lecture|
        speakers.push(lecture.user)
      end
      @users = speakers.uniq
    end
  end

  def notifications
    @notifications = Notification.where(user_id: @user.id, displayed: false).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end


  def mark_notification
    notification = Notification.find params[:notification_id]
    notification.displayed = true

    respond_to do |format|
      if notification.save
        format.html { redirect_to notifications_user_url(id: current_user.id), notice: 'Notificação lida.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to notifications_user_url(id: current_user.id), notice: 'Erro.' }
        format.json { render :show, status: :error, location: @user }
      end
    end
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
      params.require(:user).permit(:provider, :uid, :name,:image,:token,:expires_at,:review_id,:email)
    end
end
