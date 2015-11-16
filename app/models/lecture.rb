class Lecture < ActiveRecord::Base
  has_many :enrollments
  has_many :users, through: :enrollments
  belongs_to :user, foreign_key: 'speaker_id'


  def speaker
    User.find(self.speaker_id)
  end

  def self.search(query)
  	where("theme like ?", "%#{query}%")
  end
end
