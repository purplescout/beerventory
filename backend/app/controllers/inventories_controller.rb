class InventoriesController < ApplicationController
  def show
    inventories = Inventory.where(organization: params[:organization_id]).where("amount > 0").all

    render json: inventories
  end

  def update
    Inventory.transaction do
      params[:beers].each do |beer_info|
        amount_change = beer_info[:amount].to_i
        inventory = Inventory.where(organization: params[:organization_id], beer_id: beer_info[:id]).first_or_initialize
        inventory.amount += amount_change
        inventory.save!

        history = History.where(organization: params[:organization_id], user: current_user, beer_id: beer_info[:id]).first_or_initialize
        if amount_change > 0
          history.in += amount_change
        else
          history.out += amount_change.abs
        end
        history.save!
      end
    end

    head :ok
  rescue ActiveRecord::StatementInvalid, NoMethodError
    render json: { errors: { error: "An error occurred" } }, status: :bad_request
  end
end
