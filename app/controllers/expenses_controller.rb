# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :save_filter_dates, only: :index

  def index
    if start_date <= end_date
      @expenses = current_user.expenses.between(start_date, end_date)
    else
      redirect_to expenses_path, flash: { error: 'Start date must be before end date.' }
    end
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    @expense = current_user.expenses.new(expense_params)
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

  def save_filter_dates
    session[:start_date] = params[:start_date] if params[:start_date].present?
    session[:end_date]   = params[:end_date]   if params[:end_date].present?
  end

  def start_date
    return Date.parse(params[:start_date]) if params[:start_date].present?
    return Date.parse(session[:start_date]) if session[:start_date].present?
    Time.zone.today.beginning_of_month
  end
  helper_method :start_date

  def end_date
    return Date.parse(params[:end_date]) if params[:end_date].present?
    return Date.parse(session[:end_date]) if session[:end_date].present?
    Time.zone.today
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
