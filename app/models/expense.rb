# frozen_string_literal: true

class Expense < ApplicationRecord
  monetize :amount_stotinkas, numericality: { greater_than_or_equal_to: 0.1 }, as: 'amount'

  acts_as_ordered_taggable

  belongs_to :user

  validates :date, presence: true

  after_initialize { |expense| expense.date ||= Time.zone.today }

  def self.between(start_date, end_date)
    where('date >= ? AND date <= ?', start_date, end_date)
  end
end
