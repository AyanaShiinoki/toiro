require 'rails_helper'

RSpec.describe User, type: :model do

	describe 'バリデーションのテスト' do
			before do
				@user = build(:user)
			end
			it '値が全て適切' do
				expect(@user.valid?).to eq(true)
			end
		context 'nameカラム' do
			it 'nameが空欄でない' do
				@user.name = ''
				expect(@user.valid?).to eq(false)
			end
		    it '2文字以上であること' do
				@user.name = Faker::Lorem.characters(number:1)
				expect(@user.valid?).to eq(false)
		    end
		    it '20文字以下であること' do
		    	@user.name = Faker::Lorem.characters(number:21)
		    	expect(@user.valid?).to eq(false)
		    end
		end
		context 'emailカラム' do
			it 'emailが空欄でない' do
				@user.email = ''
				expect(@user.valid?).to eq(false)
			end
		end
		context 'introductionカラム' do
			it '150文字以下であること' do
				@user.introduction =  Faker::Lorem.characters(number:151)
				expect(@user.valid?).to eq(false)
			end
		end
	end
	describe 'アソシエーションのテスト' do
		context 'Galleryとの関係' do
			it '1:1となっている' do
				expect(User.reflect_on_association(:gallery).macro).to eq :has_one
			end
		end
		context 'Exhibitionとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:exhibitions).macro).to eq :has_many
			end
		end
		context 'Workとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:works).macro).to eq :has_many
			end
		end
		context 'Likeとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:likes).macro).to eq :has_many
			end
		end
		context 'Folderとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:folders).macro).to eq :has_many
			end
		end
		context 'Commentとの関係' do
			it '1:Nとなっている' do
				expect(User.reflect_on_association(:comments).macro).to eq :has_many
			end
		end
	end


end