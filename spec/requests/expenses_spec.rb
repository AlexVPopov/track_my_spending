require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  before(:each) { login_user }

  describe "GET /expenses" do
    it "works! (now write some real specs)" do
      get expenses_path
      expect(response).to have_http_status(200)
    end
  end
end

def login_user
  user = Fabricate :user
  post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
end
