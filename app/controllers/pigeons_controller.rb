class PigeonsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :find_pigeon, only: %i[show edit update destroy]

  def index
    @mapbox_access_token = ENV.fetch("MAPBOX_ACCESS_TOKEN", nil)
    @pigeons = Pigeon.all.geocoded

    @pigeons = @pigeons.where("name ILIKE ?", "%#{params[:name]}%").order("created_at DESC") unless params[:name].blank?
    @pigeons = @pigeons.near(params[:address], 100) unless params[:address].blank?

    @markers = @pigeons.map { |pigeon| render_to_string(partial: "marker", locals: { pigeon: }) }
  end

  def show
    @user = current_user
    @rental = Rental.new(service_fee_per_day: 10, tax_rate: 0.2)
    # @review = Review.find(params[:pigeon_id])
    # @pigeon.reviews = @review
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
    redirect_to profile_path(current_user), status: :see_other
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :address, :photo, :price)
  end

  def find_pigeon
    @pigeon = Pigeon.find(params[:id])
  end
end
