class PlantTypesController < ApplicationController
  def show
    @type = PlantType.find(params[:id])
  end
end
