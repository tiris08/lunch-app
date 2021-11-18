require 'rails_helper'

RSpec.describe FoodItemDecorator, type: :decorator do
  let(:food_decorator) { FoodItemDecorator.new(food_item) }
  let(:food_item) do
    build_stubbed(:food_item, course: 'first_course',
                              price:  2.99,
                              name:   'Sandwich')
  end

  describe '#humanized_course' do
    it 'returns correctly formatted course' do
      expect(food_decorator.humanized_course).to eql('First course')
    end
  end

  describe '#price_in_currency' do
    it 'returns correctly price with dollar symbol' do
      expect(food_decorator.price_in_currency).to eql('$2.99')
    end
  end

  describe '#info_mail' do
    it 'returns formatted sentance' do
      expect(food_decorator.info_mail).to eql('Sandwich (First course) - $2.99')
    end
  end
end
