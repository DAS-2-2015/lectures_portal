Given /(?:|I ) own a lecture$/ do
  @lecture = FactoryGirl.create(:lecture)
end

Given /(?:|A ) lecture with speaker is registered$/ do
  @lecture = FactoryGirl.create(:lecture)
  @user = FactoryGirl.create(:user)
  @lecture.speaker_id = @user.id
end
