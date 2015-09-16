class DateValidator
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def check_dates
    ensure_start_before_end_date
    ensure_start_date_valid
    ensure_end_date_valid
  end

  private

    def ensure_start_before_end_date
      raise ArgumentError, 'Start date must be before end date.' if start_date > end_date
    end

    def ensure_start_date_valid
      oldest_expense_date = Expense.oldest_date
      if start_date < oldest_expense_date
        raise ArgumentError, "Start date must be after #{oldest_expense_date}."
      end
    end

    def ensure_end_date_valid
      raise ArgumentError, 'End date must be before today.' if end_date > Time.zone.today
    end
end
