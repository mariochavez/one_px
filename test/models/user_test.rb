require 'test_helper'

describe User do
  describe 'validations' do
    let(:user) { User.new email: 'user@test.com', password: 'password', password_confirmation: 'password' }

    it 'is valid' do
      user.must_be :valid?
    end

    it 'is invalid when no email is provided' do
      user.email = nil

      user.wont_be :valid?
      user.errors.count.must_equal 1
      user.errors[:email].wont_be :empty?
      user.errors[:email].first.must_match /requerido/
    end

    it 'is invalid when email is not unique' do
      user.email = 'user1@test.com'

      user.wont_be :valid?
      user.errors.count.must_equal 1
      user.errors[:email].wont_be :empty?
      user.errors[:email].first.must_match /en uso/
    end
  end
end
