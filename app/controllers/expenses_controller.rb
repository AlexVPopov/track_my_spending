class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = current_user.expenses
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
      redirect_to @expense, notice: 'Expense was successfully updated.'
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

    def set_expense
      find_expense
      check_ownership
    end

    def find_expense
      @expense = Expense.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'Expense not found.'
    end

    def check_ownership
      unless @expense.user_id == current_user.id
        redirect_to expenses_path,
                    alert: 'You do not have access to this expense or expense doesn\'t exist.'
      end
    end

    def expense_params
      params.require(:expense).permit(:amount, :date)
    end
end
