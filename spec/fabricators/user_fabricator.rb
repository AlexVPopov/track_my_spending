Fabricator(:user) do
  email { FFaker::Internet.email }
  pass = FFaker::Internet.password
  password pass
  password_confirmation pass
end
