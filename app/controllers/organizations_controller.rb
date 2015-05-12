class OrganizationsController < ApplicationController
  def index
    @organizations = current_user.organizations
  end

  def join
    @organization = Organization.where(code: params[:code]).first
    @membership = Membership.new(organization: @organization, user: current_user, role: "member")

    if @membership.save
      redirect_to @organization
    else
      redirect_to organizations_url, alert: @membership.errors.full_messages.join(", ")
    end
  end

  def leave
    @organization = Organization.find(params[:id])
    @membership = Membership.where(organization: @organization, user: current_user).first

    if @membership.destroy
      redirect_to :organizations
    else
      redirect_to @organization, alert: "Could not leave"
    end
  end

  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html {}
      format.json { render json: @organization, status_values: true }
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      Membership.create(organization: @organization, user: current_user, role: "admin")

      redirect_to @organization
    else
      render :new
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :code)
  end
end
