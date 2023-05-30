class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # @user.pigeons = Pigeon.find(params[:id])
    # @pigeon = Pigeon.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def pigeon_params
    params.require(:pigeon).permit(:name, :maximum_payload_weight, :range, :description, :address, :photo)
  end
end
