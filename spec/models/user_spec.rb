# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it('has a valid fabricator') { expect(Fabricate(:user)).to be_valid }

  describe 'associations' do
    it { is_expected.to have_many(:expenses).order(date: :desc).dependent(:destroy) }
  end

  describe 'scopes' do
    describe '.admins' do
      let!(:non_admin) { Fabricate(:user) }
      let!(:admin) { Fabricate(:admin) }

      it 'returns the admins' do
        expect(User.ids).to match_array [non_admin.id, admin.id]
        expect(described_class.admins).to match_array [admin]
      end
    end
  end
end
