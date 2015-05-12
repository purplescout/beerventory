class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      format.html do
        if @user.save
          auto_login(@user)
          redirect_to :organizations
        else
          render :new
        end
      end
      format.json do
        organization = Organization.where(code: params[:invitation_code]).first
        membership = Membership.new(organization: organization, user: @user, role: "member")

        User.transaction do
          if @user.save
            if membership.save
              auto_login(@user)
              render json: @user
            else
              render json: { errors: membership.errors }, status: :unprocessable_entity
              raise ActiveRecord::Rollback
            end
          else
            render json: { errors: @user.errors }, status: :unprocessable_entity
          end
        end
      end
    end
  end

  def me
    render json: current_user
  end

  def index
    organization = Organization.find(params[:organization_id])

    render json: organization.users, skip_organizations: true, include_amount_for_organization: organization
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
