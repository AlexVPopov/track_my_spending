class Expense < ActiveRecord::Base
  belongs_to :user

  monetize :amount_stotinkas, numericality: {greater_than_or_equal_to: 0.1}

  validates :date, presence: true
end
