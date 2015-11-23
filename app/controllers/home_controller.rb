class HomeController < ApplicationController
  def index
  end

  def show
  	@user = User.find_by_id session[:user_id]
  	
    if @user.lectures.count == 0
      ranking_lecturers
    else
      self.recomendation_lecturers
    end
  end

  def ranking_lecturers
    @users = User.order(:rate).limit(5).where.not(id: @user.id).reverse
  end

  def recomendation_lecturers
    lecturers_ranked = []

    @user.lectures(limit: 5).reverse.each do |user_lecture| 
      Lecture.find_each do |lecture|
        if lecture.title == user_lecture.title
          if lecture.user != @user
            lecturers_ranked.push(lecture.user)
          end
        end
      end
    end
    lecturers_ranked = lecturers_ranked.uniq
    @users = lecturers_ranked.sort_by {|obj| obj.rate}.reverse
  end
    
end
