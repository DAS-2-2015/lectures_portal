class SessionsController < ApplicationController
  def new
    if session[:user_id].nil?
      redirect_to '/auth/facebook'
    else
      redirect_to user_page_url
    end
  end

  def create
    user = User.omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to user_page_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
