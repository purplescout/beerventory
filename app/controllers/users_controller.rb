class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      respond_to do |format|
        format.html { redirect_to :organizations }
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  def me
    render json: current_user
  end

  def index
    organization = Organization.find(params[:organization_id])

    render json: organization.users, skip_organizations: true
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
