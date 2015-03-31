class HistoriesController < ApplicationController
  def show
    histories = History.where(organization: params[:organization_id], user: current_user).all

    render json: histories
  end
end
