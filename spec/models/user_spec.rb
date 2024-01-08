require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "ユーザー登録できる場合" do
      it "必要項目が全て正しく記入されている" do
        expect(@user).to be_valid
      end
    end
    context "ユーザー登録できない場合" do
      it "ニックネームが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "Eメールアドレスが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "Eメールアドレスが重複していては登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "Eメールアドレスは@が含まれていないと登録できない" do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "パスワードが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードとパスワード確認が一致しないと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '222222'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

      end
      it 'パスワードが129文字以上では登録できない' do
        @user.email = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
    end
  end

end
