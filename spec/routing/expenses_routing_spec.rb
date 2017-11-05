# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpensesController, type: :routing do
  describe 'routing' do
    it { is_expected.to route(:get, '/expenses').to(action: :index) }

    it { is_expected.to route(:get, '/expenses/new').to(action: :new) }

    it { is_expected.to route(:get, '/expenses/1').to(action: :show, id: 1) }

    it { is_expected.to route(:get, '/expenses/1/edit').to(action: :edit, id: 1) }

    it { is_expected.to route(:post, '/expenses').to(action: :create) }

    it { is_expected.to route(:put, '/expenses/1').to(action: :update, id: 1) }

    it { is_expected.to route(:patch, '/expenses/1').to(action: :update, id: 1) }

    it { is_expected.to route(:delete, '/expenses/1').to(action: :destroy, id: 1) }
  end
end
