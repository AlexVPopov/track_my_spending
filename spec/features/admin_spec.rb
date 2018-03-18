# frozen_string_literal: true

require 'rails_helper'

feature 'Access to admin dashboard' do
  context 'When a user is not an admin' do
    given(:user) { Fabricate :user }

    background { login_as(user, scope: :user) }

    scenario 'they get redirected to the root page' do
      visit admin_root_path

      expect(page.current_path).to eq authenticated_root_path
    end
  end

  context 'when a user is an admin' do
    given(:user) { Fabricate :admin }

    background { login_as(user, scope: :user) }

    scenario 'they are given access to the admin dashboard' do
      visit admin_root_path

      expect(page.current_path).to eq admin_root_path
    end
  end
end
