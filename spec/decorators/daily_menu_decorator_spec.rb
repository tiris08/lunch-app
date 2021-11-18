require 'rails_helper'

RSpec.describe DailyMenuDecorator, type: :decorator do
  let(:menu_decorator) { DailyMenuDecorator.new(menu) }
  let(:menu) { build_stubbed(:daily_menu, created_at: Time.zone.now) }

  describe '#formatted_created_at' do
    it 'returns correctly fromatted created_at' do
      formatted_date = menu.created_at.strftime('%d %b %Y')
      expect(menu_decorator.formatted_created_at).to eql(formatted_date)
    end
  end

  describe '#formatted_created_at_long' do
    it 'returns correctly fromatted created_at' do
      formated_date = menu.created_at.strftime('%A %d %b %Y')
      expect(menu_decorator.formatted_created_at_long).to eql(formated_date)
    end
  end

  describe '#created_at_day' do
    it 'returns correctly fromatted created_at' do
      formated_date = menu.created_at.strftime('%A')
      expect(menu_decorator.created_at_day).to eql(formated_date)
    end
  end

  describe '#created_at_day_month' do
    it 'returns correctly fromatted created_at' do
      formated_date = menu.created_at.strftime('%b %d')
      expect(menu_decorator.created_at_day_month).to eql(formated_date)
    end
  end
end
