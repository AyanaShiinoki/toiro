require 'rails_helper'

RSpec.describe Work, type: :model do
	before do
		@work = build(:work)
	end

	describe 'バリデーションのテスト' do
		context 'work_titleカラム' do
			it '空欄でないこと' do
				 @work.work_title = ''
				 expect(@work.valid?).to eq(false)
			end
			it '20文字以下であること' do
				@work.work_title = Faker::Lorem.characters(number:21)
				expect(@work.valid?).to eq(false)
			end
		end

		context 'descriptionカラム' do
			it '100文字以下であること' do
				@work.description = Faker::Lorem.characters(number:101)
				expect(@work.valid?).to eq(false)
			end
		end
	end

	describe '外部キーのテスト' do
		context '保存できない場合' do
			  it "user_idが無ければ無効" do
			    @work = Work.new(user_id: nil)
			    @work.valid?
			    expect(@work.valid?).to eq(false)
			  end

			  it 'exhibition_idが無ければ無効' do
			  	@work = Work.new(exhibition_id: nil)
			  	expect(@work.valid?).to eq(false)
			  end
		end
		context '保存できる場合' do
			  it "user_idとexhibition_idがあれば有効" do
			  	@user = build(:user)
			  	@exhibition = build(:exhibition)
			    expect(FactoryBot.create(:work,user_id: @user.id,exhibition_id: @exhibition.id)).to be_valid
			  end
		end
	end

	# description 'アソシエーションのテスト' do
	# 	context 'Userとの関係' do
	# 		it '1:Nとなっている' do
	# 			expect(Work.reflect_on_association(:user).macro).to eq :belongs_to
	# 		end
	# 	end
	# end

end