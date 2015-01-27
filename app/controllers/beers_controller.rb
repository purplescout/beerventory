class BeersController < ApplicationController
  def show
    beer = Beer.where(barcode: params[:id]).first

    render json: beer
  end
end
