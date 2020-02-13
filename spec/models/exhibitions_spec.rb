require 'rails_helper'

RSpec.describe Exhibition, type: :model do
	before do
		@exhibition = build(:exhibition)
	end

	describe 'バリデーションのテスト' do
		context 'titleカラム' do
			it '空欄でないこと' do
				@exhibition.title = ''
				expect(@exhibition.valid?).to eq(false)
			end
			it '20文字以下であること' do
				@exhibition.title = Faker::Lorem.characters(number:21)
				expect(@exhibition.valid?).to eq(false)
			end
		end

		context 'captionカラム' do
			it '空欄でないこと' do
				@exhibition.caption = ''
				expect(@exhibition.valid?).to eq(false)
			end
			it '101文字以下であること' do
				@exhibition.caption = Faker::Lorem.characters(number:102)
				expect(@exhibition.valid?).to eq(false)
			end
		end
	end

		context '外部キーのテスト' do
			  it "user_idがなければ無効" do
			    @exhibition = Exhibition.new(user_id: nil)
			    @exhibition.valid?
			    expect(@exhibition.valid?).to eq(false)
			  end

			  it "gallery_idがなければ無効" do
			    @exhibition = Exhibition.new(gallery_id: nil)
			    @exhibition.valid?
			    expect(@exhibition.valid?).to eq(false)
			  end
		end

	describe 'アソシエーションのテスト' do
		context 'Userとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'Workとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:works).macro).to eq :has_many
			end
		end

		context 'Likeとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:likes).macro).to eq :has_many
			end
		end

		context 'Commentとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:comments).macro).to eq :has_many
			end
		end

		context 'Clipとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:clips).macro).to eq :has_many
			end
		end

		context 'Folderとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:folders).macro).to eq :has_many
			end
		end

		context 'Notificationとの関係' do
			it '1:Nとなっている' do
				expect(Exhibition.reflect_on_association(:notifications).macro).to eq :has_many
			end
		end

	end


end