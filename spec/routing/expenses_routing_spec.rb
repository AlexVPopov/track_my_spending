# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpensesController, type: :routing do
  describe 'routing' do
    it { should route(:get, '/expenses').to(action: :index) }

    it { should route(:get, '/expenses/new').to(action: :new) }

    it { should route(:get, '/expenses/1').to(action: :show, id: 1) }

    it { should route(:get, '/expenses/1/edit').to(action: :edit, id: 1) }

    it { should route(:post, '/expenses').to(action: :create) }

    it { should route(:put, '/expenses/1').to(action: :update, id: 1) }

    it { should route(:patch, '/expenses/1').to(action: :update, id: 1) }

    it { should route(:delete, '/expenses/1').to(action: :destroy, id: 1) }
  end
end
