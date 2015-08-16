require 'rails_helper'

RSpec.describe Expense, type: :model do
  it('has a valid fabricator') { expect(Fabricate(:expense)).to be_valid }

  context 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0.1) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'money' do
    it { is_expected.to monetize(:amount).with_currency(:bgn) }
  end
end
