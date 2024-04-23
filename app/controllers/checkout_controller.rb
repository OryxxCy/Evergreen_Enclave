class CheckoutController < ApplicationController

  def create
    order = Order.find_by(id: params[:order_id])
    line_items = []

    order.order_plants.each do |order_plant|
      line_items << {
        quantity: order_plant.quantity,
        price_data: {
          unit_amount: (order_plant.ordered_price * 100).to_i,
          currency: "cad",
          product_data: {
            name: order_plant.plant.name,
            }
          }
      }
    end

    line_items << {
      quantity: 1,
      price_data: {
        currency: "cad",
        unit_amount: (order.gst_tax * 100).to_i,
        product_data: {
          name: "GST",
          description: "Goods and Services Tax",
          }
        }
    }

    line_items << {
      quantity: 1,
      price_data: {
        currency: "cad",
        unit_amount: (order.pst_tax * 100).to_i,
        product_data: {
          name: "PST",
          description: "Provincial Sales Tax",
          }
        }
    }

    line_items << {
      quantity: 1,
      price_data: {
        currency: "cad",
        unit_amount: (order.hst_tax * 100).to_i,
        product_data: {
          name: "HST",
          description: " Harmonized Sales Tax",
          }
        }
    }

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}&order_id=#{order.id}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: line_items
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    order = Order.find_by(id: params[:order_id])
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    order.order_status_id = 2
    order.payment_id = @payment_intent.id
    order.save
    redirect_to order_path(order.id)
  end

  def cancel
    redirect_to orders_path
  end
end