require 'google/api_client'

class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy, :enroll]
  include LecturesHelper

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all

    if params[:search]
      @lectures = Lecture.search(params[:search])
    elsif params[:searchNear]
      @lectures = Lecture.near(params[:searchNear], 50)
    else
      @lectures = Lecture.all
    end
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @speaker = User.find(@lecture.speaker_id)
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.speaker_id = params[:lecture][:speaker_id]

    respond_to do |format|
      if @lecture.save
        dispare_notifications

        format.html { redirect_to @lecture, notice: 'Palestra foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Palestra foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Palestra foi apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  def authorize
    if params[:code].nil?
      get_token
      session[:lecture_id] = params[:format]
      session[:current_user_id] = params[:current_user_id]
      redirect_to @auth_client.authorization_uri.to_s
    else
      redirect_to controller: 'lectures', action: 'enroll', id: session[:lecture_id], current_user_id: session[:current_user_id], code: params[:code]
    end
  end

  def enroll
    get_token
    event = create_enrollment @lecture
    respond_to do |format|
      if event == "Success"
        format.html { redirect_to @lecture, notice: 'Inscrição feita com sucesso.' }
        format.json { render :show, status: :ok, location: @lecture }
      elsif event == "Not availability"
        format.html { redirect_to @lecture, notice: 'Você já tem um evento cadastrado para este momento.' }
        format.json { render :show, status: :error, location: @lecture }
      else
        format.html { redirect_to @lecture, notice: 'Erro ao criar evento.' }
        format.json { render :show, status: :error, location: @lecture }
      end
    end
  end

  def search_near
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:title, :theme, :description, :price, :duration, :date, :address)
    end
end
