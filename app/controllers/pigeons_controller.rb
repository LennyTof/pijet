class PigeonsController < ApplicationController
  before_action :authenticate_user!, only: :new
  
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

  def edit
    @pigeon = Pigeon.find(params[:id])
  end

  def update
    @pigeon = Pigeon.find(params[:id])
    if @pigeon.update(pigeon_params)
      redirect_to @pigeon
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pigeon = Pigeon.find(params[:id])
    @pigeon.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :address, :photo)
  end
end
