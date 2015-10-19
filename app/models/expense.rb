class Expense < ActiveRecord::Base
  belongs_to :user

  monetize :amount_stotinkas, numericality: {greater_than_or_equal_to: 0.1}

  validates :date, presence: true
  validates :user, presence: true

  acts_as_ordered_taggable

  def self.oldest_date
    order(date: :asc).pluck(:date).first || Time.zone.today
  end

  def self.between(start_date, end_date)
    where('date >= ? AND date <= ?', start_date, end_date)
  end
end
