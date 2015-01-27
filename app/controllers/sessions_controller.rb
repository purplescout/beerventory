class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(:organizations)
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(root_url, notice: 'Logged out!')
  end
end
