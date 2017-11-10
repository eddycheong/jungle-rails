class OrderMailer < ApplicationMailer
  default from: ENV["GMAIL_ACCOUNT"]

  def receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Jungle Order ##{order.id} Receipt")
  end
end
