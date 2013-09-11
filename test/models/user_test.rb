require 'test_helper'

describe User do
  let(:user) { User.new email: 'user@test.com', password: 'password', password_confirmation: 'password' }

  describe 'associations' do
    it 'has many photos' do
      user.must_respond_to :photos
    end
  end

  describe 'validations' do
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

    it 'is invalid when password is blank' do
      user = User.new email: 'user@test.com'

      user.wont_be :valid?
      user.errors.count.must_equal 1
      user.errors[:password].wont_be :empty?
      user.errors[:password].first.must_match /requerido/
    end
  end
end
