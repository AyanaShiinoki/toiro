require 'rails_helper'


RSpec.describe Exhibition, type: :system do

	let(:user) { create(:user) }
	let!(:user2) { create(:user)}
	let!(:user3) { create(:user)}
	let!(:gallery) { create(:gallery, user: user) }
	let!(:gallery2) { create(:gallery, user: user2) }
	let!(:gallery3) { create(:gallery, user: user3) }

	let!(:exhibition) { create(:exhibition, gallery_id: gallery.id,user: user) }
	let!(:exhibition2) { create(:exhibition, gallery_id: gallery2.id, user: user2) }
	let!(:exhibition3) { create(:exhibition, gallery_id: gallery3.id, user: user3) }
	let!(:work) { create(:work, exhibition: exhibition,user: user) }
	let!(:work2) { create(:work, exhibition: exhibition,user: user) }

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
			it '作品タイトルフォームが表示される' do
				expect(page).to have_field 'exhibition[works_attributes][0][work_title]'
			end
			it '作品説明フォームが表示される' do
				expect(page).to have_field 'exhibition[works_attributes][0][description]'
			end
			it '作品画像フォームが表示される' do
				expect(page).to have_field 'exhibition[works_attributes][0][work_image]'
			end
			it 'Createボタンが表示される' do
		  	expect(page).to have_button '開催'
		  	end

		  	it '投稿に成功する' do
		  		fill_in 'exhibition[title]', with: Faker::Lorem.characters(number:5)
		  		fill_in 'exhibition[caption]', with: Faker::Lorem.characters(number:10)
		  		fill_in 'exhibition[works_attributes][0][work_title]', with: Faker::Lorem.characters(number:10)
		  		fill_in 'exhibition[works_attributes][0][description]', with: Faker::Lorem.characters(number:10)
		  		click_button '開催'
		  		expect(page).to have_content exhibition[title]
		  	end
		end
	end

	describe '編集のテスト' do
		context '自分の個展の編集画面に遷移' do
			it '遷移できる' do
				visit edit_users_exhibition_path(exhibition)
				expect(current_path).to eq('/users/exhibitions/' + exhibition.id.to_s + '/edit')
			end
		end
		context '他人の個展の編集画面に遷移' do
			it '遷移できない' do
				visit edit_users_exhibition_path(exhibition2)
				expect(current_path).to eq(root_path)
			end
		end

		context '表示のテスト' do
			before do
				visit edit_users_exhibition_path(exhibition)
			end
			it 'タイトル編集フォームが表示される' do
				expect(page).to have_field 'exhibition[title]', with: exhibition.title
			end
			it 'タイトル編集フォームが表示される' do
				expect(page).to have_field 'exhibition[caption]', with: exhibition.caption
			end
			it '作品タイトル編集フォームが表示される' do
				expect(page).to have_field 'exhibition[works_attributes][0][work_title]',with: work.work_title
			end
			it '作品説明編集フォームが表示される' do
				expect(page).to have_field 'exhibition[works_attributes][0][description]',with: work.description
			end
			it '作品画像編集フォームが表示される' do
				expect(page).to have_field 'exhibition[works_attributes][0][work_image]',with: work.work_image
			end
			it 'Updateボタンが表示される' do
		  		expect(page).to have_button '更新'
		  	end
		end
		context '更新の確認' do
			it '更新に成功する' do
				visit edit_users_exhibition_path(exhibition)
				click_button '更新'
				expect(current_path).to eq ('/users/exhibitions/' + exhibition.id.to_s )
			end
			it '更新に失敗する' do
				visit edit_users_exhibition_path(exhibition)
				fill_in 'exhibition[title]', with: ''
				click_button '更新'
				expect(current_path).to eq ('/users/exhibitions/' + exhibition.id.to_s + '/edit')
			end
		end
	end

	describe '一覧画面のテスト' do
		before do
			visit users_exhibitions_path
		end
		context '表示のテスト' do
			it '開催中個展一覧と表示される' do
				expect(page).to have_content('開催中個展一覧')
			end
			it '個展タイトルが表示される' do
  				expect(page).to have_content exhibition.user.name
  				expect(page).to have_content exhibition2.user.name
  				expect(page).to have_content exhibition3.user.name
  			end
  			it '個展主催者名が表示される' do
  				expect(page).to have_content exhibition.user.name
  				expect(page).to have_content exhibition2.user.name
  				expect(page).to have_content exhibition3.user.name
  			end
		end
	end

	describe '詳細画面のテスト' do
		context '表示のテスト' do
			it '個展タイトルが表示される' do
				visit users_exhibition_path(exhibition)
				expect(page).to have_content exhibition.title
			end
			it '個展概要が表示される' do
				visit users_exhibition_path(exhibition)
				expect(page).to have_content exhibition.caption
			end
			it '作品タイトルが表示される' do
				visit users_exhibition_path(exhibition)
				expect(page).to have_content work.work_title
			end
			it '作品説明が表示される' do
				visit users_exhibition_path(exhibition)
				expect(page).to have_content work.description
			end
			it '作品画像が表示される' do
				visit users_exhibition_path(exhibition)
				expect(page).to have_content work.work_image
			end
		end

		context 'リンクのテスト' do
			it '編集リンクが表示される' do
				visit users_exhibition_path(exhibition)
				expect(page).to have_link '編集', href: edit_users_exhibition_path(exhibition)
			end
			it '他人の投稿の編集リンクは表示されない' do
				visit users_exhibition_path(exhibition2)
				expect(page).to have_no_link '編集', href: edit_users_exhibition_path(exhibition2)
			end

		end

	end





end