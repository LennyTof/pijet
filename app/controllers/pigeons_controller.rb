class PigeonsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :find_pigeon, only: %i[show edit update destroy]

  def index
    @mapbox_access_token = ENV["MAPBOX_ACCESS_TOKEN"]
    @pigeons = Pigeon.all
    @markers = @pigeons.map { |pigeon| render_to_string(partial: "marker", locals: { pigeon: }) }

    if params[:search]
      @pigeons = Pigeon.search(params[:search]).order("created_at DESC")
    else
      @pigeons = Pigeon.all.order("created_at DESC")
    end

  end

  def show
    @user = current_user
    @rental = Rental.new
  end

  def new
    @pigeon = Pigeon.new
  end

  def create
    @pigeon = Pigeon.new(pigeon_params)
    @pigeon.user = current_user
    if @pigeon.save
      redirect_to pigeon_path(@pigeon)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @pigeon.update(pigeon_params)
      redirect_to @pigeon
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pigeon.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :address, :photo)
  end

  def find_pigeon
    @pigeon = Pigeon.find(params[:id])
  end
end
