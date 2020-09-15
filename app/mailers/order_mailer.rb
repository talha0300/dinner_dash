class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order]

    mail(to: "unknown@example.com", subject: "You placed an order")
  end
end
