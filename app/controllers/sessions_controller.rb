class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
  end

  def create
    if login(params[:email], params[:password])
      respond_to do |format|
        format.html { redirect_back_or_to(:organizations) }
        format.json { render json: current_user }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = 'Login failed'
          render :new
        end
        format.json { render json: { errors: "Wrong email or password" } }
      end
    end
  end

  def destroy
    logout

    respond_to do |format|
      format.html { redirect_to(root_url, notice: 'Logged out!') }
      format.json { head :ok }
    end
  end
end
