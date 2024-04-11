class CartController < ApplicationController
  def create
    product_id = params[:id]
    quantity = params[:quantity].to_i
    if session[:shopping_cart].key?(product_id)
      session[:shopping_cart][product_id] += quantity
    else
      session[:shopping_cart][product_id] = quantity
    end

    plant = Plant.find(product_id)
    flash[:notice] = "#{quantity} #{plant.name} added to cart."
  end

  def destroy
    id = params[:id]
    session[:shopping_cart].delete(id)
    plant = Plant.find(id)

    flash[:notice] = "#{plant.name} removed from cart."
    redirect_to cart_index_path
  end

  def index
    cart_items = session[:shopping_cart]
    @cart_products = Plant.where(id: cart_items.keys)
    @cart_items_with_quantity = {}
    @cart_products.each do |product|
      quantity = cart_items[product.id.to_s]
      @cart_items_with_quantity[product] = quantity
    end
  end
end
