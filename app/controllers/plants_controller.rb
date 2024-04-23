class PlantsController < ApplicationController
  def index
    @plants = Plant.page(params[:page]).per(12)
  end

  def show
    @plant = Plant.find(params[:id])
    @type = PlantType.find(@plant.plant_type.id)
    @plants = @type.plants.where.not(id: @plant.id).limit(8)
    if session[:shopping_cart][@plant.id.to_s].present?
      @plant_current_stock = @plant.stock - session[:shopping_cart][@plant.id.to_s].to_i
      @plant_in_cart = session[:shopping_cart][@plant.id.to_s].to_i
    else
      @plant_current_stock = @plant.stock
    end
  end

  def search
    search_term = "%#{params[:keywords]}%"
    if params[:type].present?
      @plants = Plant.joins(:plant_type).where("plants.name LIKE ? AND plant_types.name = ?", search_term, params[:type])
    else
      @plants = Plant.where("name LIKE ?", search_term)
    end
    @plants_count = @plants.count
    if @plants_count > 12
      @plants = @plants.page(params[:page]).per(12)
    end
  end
end
