class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
    if params[:search]
      @pigeons = Pigeon.search(params[:search]).order("created_at DESC")
    else
      @pigeons = Pigeon.all
    end
  end
end
