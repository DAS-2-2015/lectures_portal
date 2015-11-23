require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it {should belong_to :user}
  it {should belong_to :lecture}
end
