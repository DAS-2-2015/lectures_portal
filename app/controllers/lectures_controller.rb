require 'google/api_client'

class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy, :enroll, :inscribe]
  include LecturesHelper

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
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

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
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
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
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
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def enroll
    result = get_token
    auth_client = result[1]
    result = result[0]

    if (result == false)
      redirect_to auth_client.authorization_uri.to_s
      return
    end

    availability = check_availability(auth_client, @lecture)
    
    respond_to do |format|
      if availability
        format.html { redirect_to @lecture, notice: 'Enrollment in the lecture was successful.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { redirect_to @lecture, notice: 'Enroll failed.' }
        format.json { render :show, status: :error, location: @lecture }
      end
    end
  end

  def inscribe
    current_user = User.find params[:current_user_id]
    enrollment = Enrollment.new lecture_id: @lecture.id, user_id: current_user.id

    if @lecture.price == 0
      enrollment.status = true
    end

    enrollment.save

    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Enrollment in the lecture was successful.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:title, :description, :price, :duration, :date)
    end
end