class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    if start_date <= end_date
      @expenses = current_user.expenses.between(start_date, end_date)
    else
      redirect_to expenses_path, flash: {error: 'Start date must be before end date.'}
    end
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    current_user.tag(@expense, with: params[:expense][:tag_list], on: :tags)

    if @expense.save
      redirect_to expenses_path, notice: 'Expense was successfully created.'
    else
      flash[:error] = @expense.errors.full_messages.first
      render :new
    end
  end

  def update
    current_user.tag(@expense, with: params[:expense][:tag_list], on: :tags)

    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'Expense was successfully updated.'
    else
      flash[:error] = @expense.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_url, notice: 'Expense was successfully destroyed.'
  end

  private

    def start_date
      if params[:start_date].present?
        Date.parse(params[:start_date])
      else
        Time.zone.today.beginning_of_month
      end
    end
    helper_method :start_date

    def end_date
      params[:end_date].present? ? Date.parse(params[:end_date]) : Time.zone.today
    end
    helper_method :end_date

    def set_expense
      @expense = current_user.expenses.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'Expense not found.'
    end

    def expense_params
      params.require(:expense).permit(:amount, :date)
    end
end
