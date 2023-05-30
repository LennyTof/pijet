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

  def show
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :payload_type_id)
  end
end
