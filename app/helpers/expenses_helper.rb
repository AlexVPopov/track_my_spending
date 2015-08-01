module ExpensesHelper
  def amount(expense)
    expense.amount if expense.persisted?
  end
end
