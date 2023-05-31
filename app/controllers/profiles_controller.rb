class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_pigeon, only: %i[show edit update destroy]

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo)
  end
end

private

def find_pigeon
  @pigeon = Pigeon.find(params[:id])
end
