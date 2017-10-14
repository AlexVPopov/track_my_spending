# frozen_string_literal: true

class ChangeDefaultValueForExpenseDate < ActiveRecord::Migration
  def change
    change_column_default :expenses, :date, nil
  end
end
