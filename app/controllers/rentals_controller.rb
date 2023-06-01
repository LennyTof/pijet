class RentalsController < ApplicationController
  before_action :set_rental, only: %i[show destroy]
  before_action :authenticate_user!

  def create
    @rental = Rental.new(rental_params)
    @pigeon = Pigeon.find(params[:id])

    @rental.pigeon = @pigeon
    @rental.user = current_user
    @rental.status = "pending"
    @rental.price = (@rental.end_date - @rental.start_date).to_i * @rental.pigeon.price

    if @rental.save
      redirect_to rental_path(@rental)
    else
      render "pigeons/show", status: :unprocessable_entity
    end
  end

  def accept
    @rental = Rental.find(params[:id])
    @rental.status = "accepted"
    @rental.save
    redirect_to profile_path
  end

  def show
    @rental = Rental.find(params[:id])
    @review = Review.new
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    data = params.require(:rental).permit(:start_date, :payload_type_id)

    # dirty hack
    # TODO: refactor js controller so that start_date and end_date are sent
    dates = data[:start_date].split("to").map(&:strip)
    data[:start_date] = dates[0]
    if dates.length == 2
      data[:end_date] = dates[1]
    else
      data[:end_date] = data[:start_date]
    end
    data
  end
end
