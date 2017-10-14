# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  it('has a valid fabricator') { expect(Fabricate(:expense)).to be_valid }

  context 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:user) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'money' do
    it { is_expected.to monetize(:amount).with_currency(:bgn) }
  end

  context 'initialization' do
    let(:expense) { Fabricate :expense, date: 1.day.ago.to_date }

    it 'sets the date of a new expense to today' do
      expect(Expense.new.date).to eq Time.zone.today
    end

    it 'initializes an already existing expense with the correct date' do
      expect(expense.date).to eq 1.day.ago.to_date
    end
  end

  context 'class methods' do
    let!(:old_expense)   { Fabricate :expense, date: 10.days.ago }
    let(:middle_expense) { Fabricate :expense, date: 5.days.ago }
    let(:new_expense)    { Fabricate :expense, date: Time.zone.today }

    context 'Expense.between' do
      it 'returns all expenses between a given date range' do
        expect(Expense.between(5.days.ago, Time.zone.today))
          .to eq [middle_expense, new_expense]
      end

      it 'does not return expenses outside the given date range' do
        expect(Expense.between(5.days.ago, Time.zone.today)).not_to include old_expense
      end
    end
  end
end
