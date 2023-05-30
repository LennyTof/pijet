class PigeonsController < ApplicationController
  def index
    @mapbox_access_token = ENV["MAPBOX_ACCESS_TOKEN"]
    @pigeons = Pigeon.all
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

  def new
    @pigeon = Pigeon.new
  end

  def create
    @pigeon = Pigeon.new(pigeon_params)
    @pigeon.user = current_user
    @pigeon.save
    redirect_to pigeon_path(@pigeon)
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :address, :photo)
  end
end
