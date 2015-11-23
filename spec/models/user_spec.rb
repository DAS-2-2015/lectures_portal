require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many :enrollments}
  it {should have_many :lectures}
  it {should have_many :notifications}
  it {should have_many :followers}
  it {should have_many :users}
  it {should have_many :reviews}
end
