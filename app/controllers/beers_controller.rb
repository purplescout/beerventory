class BeersController < ApplicationController
  def show
    beer = Beer.where(barcode: params[:id]).first

    if beer
      render json: beer
    else
      render json: {}, status: :not_found
    end
  end

  def create
    beer = Beer.new(beer_params)

    if beer.save
      render json: beer
    else
      render json: { errors: beer.errors }
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:barcode, :name, :volume)
  end
end
