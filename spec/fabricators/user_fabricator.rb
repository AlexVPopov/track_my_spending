# frozen_string_literal: true

Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password 'qwe123@!'
  password_confirmation 'qwe123@!'
end

Fabricator(:admin, from: :user) do
  admin true
end
