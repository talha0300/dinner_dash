class OrderMailer < ApplicationMailer
  def new_order_email
    user = params[:user][:email]

    mail(to: user, subject: "You placed an order")
  end
end
