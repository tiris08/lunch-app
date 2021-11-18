require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  it 'delivers an order details email' do
    user =  build(:user, email: 'whatever@whatever.com')
    order = build(:order, user: user)
    email = OrderMailer.with(order: order).new_order_email
    expect(email).to deliver_to('whatever@whatever.com')
    expect(email).to deliver_from('from@example.com')
    expect(email).to have_subject('You got a new order!')
    expect(email).to have_body_text('Bon Appétit!')
  end
end
