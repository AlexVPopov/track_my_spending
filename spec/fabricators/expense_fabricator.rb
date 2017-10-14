# frozen_string_literal: true

Fabricator(:expense) do
  user

  amount { rand(0.1..100).round(1) }
  date   { rand(0..10).days.ago.to_date }

  after_build do |expense, _transients|
    expense.user.tag(expense, with: FFaker::Lorem.words(rand(1..3)), on: :tags)
  end
end
