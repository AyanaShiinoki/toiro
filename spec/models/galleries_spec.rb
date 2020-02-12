require 'rails_helper'

RSpec.describe Gallery, type: :model do
	before do
		@gallery = build(:gallery)
	end

	describe 'バリデーションのテスト' do
		context 'gallery_nameカラム' do
			it '空欄でないこと' do
				@gallery.gallery_name = ''
				expect(@gallery.valid?).to eq(false)
			end

			it '20文字以下であること' do
				@gallery.gallery_name = Faker::Lorem.characters(number:21)
				expect(@gallery.valid?).to eq(false)
			end
		end

		context 'conceptカラム' do
			it '空欄でないこと' do
				@gallery.concept = ''
				expect(@gallery.valid?).to eq(false)
			end
			it '200文字以下であること' do
				@gallery.concept = Faker::Lorem.characters(number:201)
				expect(@gallery.valid?).to eq(false)
			end
		end
	end

	describe '外部キーのテスト' do
		context '保存できない場合' do
			it "user_idがなければ無効" do
			    @gallery = Gallery.new(user_id: nil)
			    @gallery.valid?
			    expect(@gallery.valid?).to eq(false)
			end
		end

		context '保存できる場合' do
			it 'user_idがあれば有効' do
				@user = build(:user)
				expect(FactoryBot.create(:gallery,user_id: @user.id)).to be_valid
			end
		end
	end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:1となっている' do
				expect(Gallery.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context 'Exhibitionとの関係' do
			it '1:Nとなっている' do
				 expect(Gallery.reflect_on_association(:exhibitions).macro).to eq :has_many
			end
		end
	end


end