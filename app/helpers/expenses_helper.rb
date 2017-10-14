# frozen_string_literal: true

module ExpensesHelper
  def amount(expense)
    expense.amount if expense.persisted?
  end
end
