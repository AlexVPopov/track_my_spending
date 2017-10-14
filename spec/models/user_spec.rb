# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it('has a valid fabricator') { expect(Fabricate(:user)).to be_valid }

  context 'associations' do
    it { should have_many(:expenses).order(date: :desc).dependent(:destroy) }
  end
end
