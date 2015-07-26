class ChangeDateTypeOfExpense < ActiveRecord::Migration
  def change
    change_column :expenses, :date, :date, default: Time.zone.today, null: false

    Expense.find_each { |expense| expense.update(date: expense.created_at.to_date) }
  end
end
