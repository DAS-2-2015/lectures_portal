class Follower < ActiveRecord::Base
  belongs_to :user
	belongs_to :panelist, class_name: :User
end
