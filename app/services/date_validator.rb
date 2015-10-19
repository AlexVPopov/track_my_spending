class DateValidator
  pattr_initialize :start_date, :end_date

  def check_dates
    ensure_start_before_end_date
    ensure_start_date_valid
  end

  private

    class InvalidStartDate < StandardError; end
    class EndDateBeforeStartDate < StandardError; end

    def ensure_start_before_end_date
      return unless end_date
      if start_date > end_date
        raise EndDateBeforeStartDate, 'Start date must be before end date.'
      end
    end

    def ensure_start_date_valid
      oldest_expense_date = Expense.oldest_date
      if start_date < oldest_expense_date
        raise InvalidStartDate, "Start date must be after #{oldest_expense_date}."
      end
    end
end
