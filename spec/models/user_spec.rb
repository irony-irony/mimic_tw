require 'rails_helper'

describe User do
  describe '#create' do
    it "is valid with all columns" do
     user = build(:user)
      user.valid?
      expect(user).to be_valid
    end


    it "is invalid without a nickname" do
     user = build(:user)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without an email" do
     user = User.build(:user)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without an password" do
     user = User.build(:user)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation though with a password" do
     user = User.build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid with a nickname that has not less than 7 charactor" do
     user = User.build(:user, nickname: "xxxxxxx")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

    it "is invalid with a nickname that has not greater than 6 charactor" do
     user = User.build(:user, nickname: "xxxxxx")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with the same email that has already been taken by someone else" do
     user = User.create(:user)
     another_user = User.build(:user, emil: user.email)
      user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

  end
end
