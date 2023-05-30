class PagesController < ApplicationController
  def home
    @pigeons = Pigeon.all
  end
end
