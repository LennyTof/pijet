class PigeonController < ApplicationController

  def show
    @pigeon = Pigeon.find(params[:id])
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :latitude, :longitude, :address)
  end
end
