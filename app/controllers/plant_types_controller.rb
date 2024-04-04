class PlantTypesController < ApplicationController
  def show
    @type = PlantType.find(params[:id])
    @plants = @type.plants
    @plants_count = @plants.count
    if @plants_count > 12
      @plants = @plants.page(params[:page]).per(12)
    end
  end
end
