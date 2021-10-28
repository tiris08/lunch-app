class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order].decorate
    mail(to: @order.user.email, subject: 'You got a new order!')
  end
end
