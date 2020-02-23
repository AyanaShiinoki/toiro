require 'rails_helper'


RSpec.describe User, type: :system do

	describe '投稿テスト' do
		let(:user) { create(:user) }
		before do
			visit new_user_session_path
		  	fill_in 'user[email]', with: user.email
		  	fill_in 'user[password]', with: user.password
		  	click_button 'Log in'
		end

		describe '投稿画面' do
			before do
				visit new_users_gallery_path
			end
			context '表示テスト' do
				it 'ギャラリーと表示される' do
					expect(page).to have_content 'ギャラリー'
				end

				it 'gallery_nameフォームが表示される' do
					expect(page).to have_field 'gallery[gallery_name]'
				end

				it 'gallery_conceptフォームが表示される' do
					expect(page).to have_field 'gallery[concept]'
				end

				it 'Create Galleryボタンが表示される' do
					expect(page).to have_button 'Open'
				end

				it '作成に成功する' do
					fill_in 'gallery[gallery_name]', with: Faker::Lorem.characters(number:10)
					fill_in 'gallery[concept]', with: Faker::Lorem.characters(number:20)
					click_button 'Open'
					expect(current_path).to eq(users_user_path(user))
				end

				it '作成に失敗する' do
					fill_in 'gallery[gallery_name]', with: ''
					fill_in 'gallery[concept]', with: ''
					click_button 'Open'
					expect(current_path).to eq(new_users_gallery_path)
				end
			end
		end

		describe '編集のテスト' do
			let(:user) { create(:user) }
			let!(:gallery) { create(:gallery, user: user) }
			let!(:user2) { create(:user) }
			let!(:gallery2) { create(:gallery, user: user2)}
			context '編集画面へ遷移' do
				it '遷移できる' do
					visit edit_users_gallery_path(gallery)
					expect(current_path).to eq('/users/galleries/' + gallery.id.to_s + '/edit')
				end
			end

			context '他人の編集画面へ遷移できない' do
				it '遷移できない' do
					visit edit_users_gallery_path(gallery2)
					expect(current_path).to eq(root_path)
				end
			end

			context '表示のテスト' do
				before do
					visit edit_users_gallery_path(gallery)
				end
				it 'Editと表示される' do
					expect(page).to have_content('Edit')
				end
				it 'gallery_name編集フォームが表示される' do
					expect(page).to have_field 'gallery[gallery_name]', with: gallery.gallery_name
				end
				it 'concept編集フォームが表示される' do
					expect(page).to have_field 'gallery[concept]', with: gallery.concept
				end
				it 'Updateボタンが表示される' do
					expect(page).to have_button '更新'
				end
			end

			# 戻るボタンのテスト

			context '更新のテスト' do
				it '編集に成功する' do
					visit edit_users_gallery_path(gallery)
					click_button '更新'
					expect(page).to have_content 'ギャラリー'
					# expect(current_path).to eq('/users/galleries/' + gallery.id.to_s)
					# expect(current_path).to eq('/users/galleries/' + gallery.id.to_s)
				end
				it '編集に失敗する' do
					visit edit_users_gallery_path(gallery)
					fill_in 'gallery[gallery_name]', with: ''
					click_button '更新'
					expect(current_path).to eq ('/users/galleries/' + gallery.id.to_s + '/edit')
					# expect(current_path).to eq('/users/galleries/' + gallery.id.to_s + '/edit')
				end
			end


		end




	end

end