class SessionsController < ApplicationController
  before_filter :logged_in, :only => :new

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
      # success logic, log them in
      session[:user_id] = user.id
      redirect_to root_path
    else
      # failure, render login form
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
