Given /(?:|I ) am an user$/ do
  @user = FactoryGirl.create(:user)
end

Given /(?:|I ) own a lecture$/ do
  @lecture = FactoryGirl.create(:lecture)
end
