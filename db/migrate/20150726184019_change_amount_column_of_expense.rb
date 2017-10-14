# frozen_string_literal: true

class ChangeAmountColumnOfExpense < ActiveRecord::Migration
  def change
    rename_column :expenses, :amount, :amount_old
    add_monetize :expenses, :amount
    reversible do |dir|
      dir.up do
        Expense.find_each { |expense| expense.update(amount: expense.amount_old) }
        remove_column :expenses, :amount_old
      end
      dir.down do
        add_column :expenses, :amount_old, :integer
        Expense.find_each { |expense| expense.update(amount_old: expense.amount) }
      end
    end
  end
end
