require 'rails_helper'

RSpec.describe Lecture, type: :model do
  it{should belong_to :user}
  it{should have_many :users}
  it{should have_many :enrollments}


end
