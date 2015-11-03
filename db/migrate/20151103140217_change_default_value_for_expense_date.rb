class ChangeDefaultValueForExpenseDate < ActiveRecord::Migration
  def change
    change_column_default :expenses, :date, nil
  end
end
