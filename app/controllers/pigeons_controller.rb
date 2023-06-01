class PigeonsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :find_pigeon, only: %i[show edit update destroy]

  def index
    @mapbox_access_token = ENV.fetch("MAPBOX_ACCESS_TOKEN", nil)
    @pigeons = Pigeon.all.geocoded

    if params[:name].present?
      @pigeons = @pigeons.where("name ILIKE ?", "%#{params[:name]}%").order("created_at DESC")
    end

    if params[:address].present?
      @pigeons = @pigeons.near(params[:address], 100)
    end

    if params[:start_date].present? && params[:end_date].present?
      sql_query = "(rentals.start_date BETWEEN :start_date AND :end_date) OR
        (rentals.end_date BETWEEN :start_date AND :end_date)"

      booked_pigeons = Pigeon.joins(:rentals).where(sql_query, start_date: params[:start_date], end_date: params[:end_date]).uniq
      @pigeons = @pigeons.excluding(booked_pigeons)
    end

    @markers = @pigeons.map { |pigeon| render_to_string(partial: "marker", locals: { pigeon: }) }
  end

  def show
    @user = current_user
    @rental = Rental.new(service_fee_per_day: 10, tax_rate: 0.2)
    @booked_dates = @pigeon.rentals.map { |rental| { from: rental.start_date, to: rental.end_date } }.uniq
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
    redirect_to root_path, status: :see_other
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :address, :photo, :price)
  end

  def find_pigeon
    @pigeon = Pigeon.find(params[:id])
  end
end
