require 'rails_helper'

RSpec.describe Admin::Users::IndexFacade, type: :facade do
  let(:facade) { Admin::Users::IndexFacade.new(params) }
  let(:params) { { page: '1' } }
  let!(:users) { create_list(:random_user, 20) }

  describe '#paginated_users' do
    it 'returns 12 decorated users per page ' do
      expect(facade.paginated_users).to be_a(PaginatingDecorator)
      expect(facade.paginated_users.size).to eql(12)
    end
  end
end
