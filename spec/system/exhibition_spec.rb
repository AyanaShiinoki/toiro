require 'rails_helper'


RSpec.describe Exhibition, type: :system do

		let(:user) { create(:user) }
		let(:user2) { create(:user)}
		let(:gallery) { create(:gallery, user: user) }
		let(:gallery2) { create(:gallery, user: user2) }
		let(:exhibition) { create(:exhibition, gallery_id: gallery.id) }
		let(:exhibition2) { create(:exhibition, gallery_id: gallery2.id) }
		let(:work) { create(:work, exhibition: exhibition) }
	before do
		visit new_user_session_path
		fill_in 'user[email]', with: user.email
		fill_in 'user[password]', with: user.password
		click_button 'Log in'
	end

	describe '投稿のテスト' do
		before do
			visit new_users_exhibition_path
		end

		context '表示のテスト' do
			it 'タイトルフォームが表示される' do
				expect(page).to have_field 'exhibition[title]'
			end
			it '概要フォームが表示される' do
			 	expect(page).to have_field 'exhibition[caption]'
			end
			# it '作品タイトルフォームが表示される' do
			# 	expect(page).to have_field 'work[work_title]'
			# end
			# it '作品説明フォームが表示される' do
			# 	expect(page).to have_field 'work[description]'
			# end
			# # it '作品画像フォームが表示される' do
			# # 	expect(page).to have_field 'work[work_image_id]'
			# # end
			it 'Create Bookボタンが表示される' do
		  	expect(page).to have_button '開催'
		  	end

		  	it '投稿に成功する' do
		  		# fill_in 'exhibition[title]', with: Faker::Lorem.characters(number:5)
		  		# fill_in 'exhibition[caption]', with: Faker::Lorem.characters(number:10)
		  		# # fill_in 'work[work_title]', with: Faker::Lorem.characters(number:10)
		  		# # fill_in 'work[description]', with: Faker::Lorem.characters(number:10)
		  		# click_button '開催'
		  		# expectc(page).to have_content exhibition.title
		  	end
		end
	end

	describe '編集のテスト' do
		context '編集画面に遷移' do
			it '遷移できる' do
				visit edit_users_exhibition_path(exhibition)
				# expect(current_path).to eq('/users/exhibitions/' + exhibition.id.to_s + '/edit' )
			end
		end
	end

	describe '一覧画面のテスト' do
		before do
			visit users_exhibitions_path
		end
		context '表示のテスト' do
			it '表示内容とリンク先が正しい' do
				# expect(page).to have_link '', href: users_exhibition_path(exhibition)
			end
		end
	end





end