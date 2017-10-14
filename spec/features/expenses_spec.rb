# frozen_string_literal: true

require 'rails_helper'

feature 'Expenses' do
  given(:user) { Fabricate :user }

  background { login_as(user, scope: :user) }

  scenario 'A user can create an expense', js: true do
    visit authenticated_root_path
    click_link 'New'
    fill_data = Fabricate.attributes_for :expense, tag_list: tag_list
    within '#new_expense' do
      fill_in 'Amount', with: fill_data[:amount]
      fill_tags(fill_data[:tag_list])
      fill_in 'Date', with: fill_data[:date]
    end
    find('input[type="submit"]').click

    expect(page.current_path).to eq expenses_path
    expect(page).to have_content 'Expense was successfully created.'
  end
end

def tag_list
  FFaker::Lorem.words(rand(1..3)).join(',')
end

def fill_tags(tag_list)
  script = "$('input[name=\"expense[tag_list][]\"]').val('#{tag_list}')"
  execute_script(script)
end
