class CheckoutController < ApplicationController

  def create
    customer = User.find_by(id: current_user.id)

    @cart_items_with_quantity = session[:shopping_cart]
    line_items = []

    order = customer.orders.new
    total_price = 0
    gst_total = 0
    pst_total = 0
    hst_total = 0
    @cart_items_with_quantity.each do |product_id, quantity|
      product = Plant.find_by(id: product_id.to_i)
      product_multiply_quantity = product.price * quantity
      product_gst = (customer.tax_rate.gst / 100) * product_multiply_quantity
      product_pst = (customer.tax_rate.pst / 100) * product_multiply_quantity
      product_hst = (customer.tax_rate.hst / 100) * product_multiply_quantity
      gst_total = gst_total + product_gst
      pst_total = pst_total + product_pst
      hst_total = hst_total + product_hst
      total_price = total_price + product_multiply_quantity

      product.update(stock: product.stock - quantity)

      order_plant = order.order_plants.build(
        quantity: quantity,
        ordered_price: product.price,
        plant_id: product.id
      )

      line_items << {
        quantity: quantity,
        price_data: {
          unit_amount: product.price,
          currency: "cad",
          product_data: {
            name: product.name,
            }
          }
      }
    end

    line_items << {
      quantity: 1,
      price_data: {
        currency: "cad",
        unit_amount: gst_total,
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
        unit_amount: pst_total,
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
        unit_amount: hst_total,
        product_data: {
          name: "HST",
          description: " Harmonized Sales Tax",
          }
        }
    }

    order.total = total_price
    order.gst_tax = gst_total
    order.pst_tax = pst_total
    order.hst_tax = hst_total
    order.save



    session[:shopping_cart] = {}

    @session = Stripe::Checkout::Session.create(
      #went to stripe API, looked up sessions, figured it all out..
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: line_items
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    # WE TAKEN YOUR MONEY
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # the transaction process stopped
  end
end