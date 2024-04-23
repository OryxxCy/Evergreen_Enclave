class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    unless current_user.orders.include?(@order)
      redirect_to orders_path
    end
  end
end
