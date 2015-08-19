require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  login_user

  it { should use_before_action(:set_expense) }

  describe 'GET #index' do
    let!(:expense) { create_expense }

    before { get :index, {} }

    it 'assigns all expenses as @expenses' do
      expect(assigns(:expenses)).to eq [expense]
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    let(:expense) { create_expense }

    before { get :show, {id: expense.to_param} }

    it 'assigns the requested expense as @expense' do
      expect(assigns(:expense)).to eq expense
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    render_views

    before { get :new, {} }

    it 'assigns a new expense as @expense' do
      expect(assigns(:expense)).to be_a_new(Expense)
    end

    it { should render_template :new }
    it { should render_template partial: '_form' }
  end

  describe 'GET #edit' do
    render_views

    let(:expense) { create_expense }

    before { get :edit, {id: expense.to_param} }

    it 'assigns the requested expense as @expense' do
      expect(assigns(:expense)).to eq expense
    end

    it { should render_template :edit }
    it { should render_template partial: '_form' }
  end

  describe 'POST #create' do
    it do
      params = {expense: Fabricate.attributes_for(:expense, tag_list: tags)}
      should permit(:amount, :date).for(:create, params: params)
    end

    context 'with valid params' do
      let(:valid_attributes) { Fabricate.attributes_for :expense, user: subject.current_user }

      before { post :create, {expense: valid_attributes} }

      it 'creates a new Expense' do
        expect { post :create, {expense: valid_attributes} }.to change(Expense, :count).by 1
      end

      it 'assigns a newly created expense as @expense' do
        expect(assigns(:expense)).to be_a Expense
        expect(assigns(:expense)).to be_persisted
      end

      it { should redirect_to action: :index }
      it { should set_flash['notice'].to 'Expense was successfully created.' }
    end

    context 'with invalid params' do
      render_views

      let(:invalid_attributes) { Fabricate.attributes_for :expense, amount: 0 }

      before { post :create, {expense: invalid_attributes} }

      it 'assigns a newly created but unsaved expense as @expense' do
        expect(assigns(:expense)).to be_a_new(Expense)
      end

      it { should render_template :new }
      it { should render_template partial: '_form' }
      it { should set_flash['error'].to assigns(:expense).errors.full_messages.first }
    end
  end

  describe 'PUT #update' do
    let(:expense) { create_expense }

    let(:new_attributes) do
      Fabricate.attributes_for :expense, user: subject.current_user, tag_list: tags
    end

    pending 'should (on PATCH #update) restrict parameters to :amount and :date'

    # it do
    #   params = {id: expense.to_param, expense: new_attributes}
    #   should permit(:amount, :date).for(:update, params: params).on(:expense)
    # end

    context 'with valid params' do
      before do
        put :update, {id: expense.to_param, expense: new_attributes}
        expense.reload
      end

      it 'updates the requested expense\'s amount' do
        expect(assigns(:expense).amount.to_f).to eq new_attributes[:amount]
      end

      it 'updates the requested expense\'s tags' do
        expect(assigns(:expense).all_tags_list).to eq new_attributes[:tag_list]
      end

      it 'assigns the requested expense as @expense' do
        expect(assigns(:expense)).to eq expense
      end

      it { should set_flash['notice'].to 'Expense was successfully updated.' }

      it 'redirects to the expense' do
        should redirect_to(expense)
      end
    end

    context 'with invalid params' do
      render_views

      let(:invalid_attributes) { Fabricate.attributes_for :expense, amount: 0 }

      before { put :update, {id: expense.to_param, expense: invalid_attributes} }

      it 'assigns the expense as @expense' do
        expect(assigns(:expense)).to eq expense
      end

      it { should set_flash['error'].to assigns(:expense).errors.full_messages.first }
      it { should render_template :edit }
      it { should render_template partial: '_form' }
    end
  end

  describe 'DELETE #destroy' do
    let!(:expense) { create_expense }

    it 'destroys the requested expense' do
      expect { delete :destroy, {id: expense.to_param} }.to change(Expense, :count).by -1
    end

    it do
      delete :destroy, {id: expense.to_param}
      should redirect_to(action: :index)
    end
  end
end

def create_expense
  Fabricate :expense, user: subject.current_user
end

def tags
  FFaker::Lorem.words(rand(1..3))
end
