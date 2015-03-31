class InventoriesController < ApplicationController
  def show
    inventories = Inventory.where(organization: params[:organization_id]).all

    render json: inventories
  end
end
