class SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    user = User.omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to user_page_url(id: session[:user_id])
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
