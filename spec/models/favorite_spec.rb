require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end
  end
end
