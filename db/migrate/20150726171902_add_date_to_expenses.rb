class AddDateToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :date, :datetime, default: Time.zone.now, null: false

    Expense.find_each { |expense| expense.update(date: expense.created_at) }
  end
end
