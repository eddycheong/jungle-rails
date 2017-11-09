
class OrderMailerPreview < ActionMailer::Preview
  def receipt_email
    order = Order.first
    OrderMailer.receipt_email(order)
  end
end