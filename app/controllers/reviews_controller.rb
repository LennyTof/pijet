class ReviewsController < ApplicationController
  def create
    @rental = Rental.find(params[:rental_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.rental = @rental
    if @review.save
      redirect_to rental_path(@rental)
    else
      render "rentals/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
