# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :user

  monetize :amount_stotinkas, numericality: { greater_than_or_equal_to: 0.1 }, as: 'amount'

  validates :date, presence: true
  validates :user, presence: true

  acts_as_ordered_taggable

  after_initialize { |expense| expense.date ||= Time.zone.today }

  def self.between(start_date, end_date)
    where('date >= ? AND date <= ?', start_date, end_date)
  end
end
