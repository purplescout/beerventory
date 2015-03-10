class BeersController < ApplicationController
  def show
    beer = Beer.where(barcode: params[:id]).first

    if beer
      render json: beer
    else
      render json: {}, status: :not_found
    end
  end
end
