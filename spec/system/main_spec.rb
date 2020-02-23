require 'rails_helper'


	describe 'ユーザー権限のテスト' do
		let(:user) { create(:user) }
		let(:exhibition) { create(:exhibition) }
		describe 'ログインしていない場合' do
			context 'アクセス権限のテスト' do

				it '個展開催画面に遷移できない' do
					visit new_users_exhibition_path
					expect(current_path).to eq('/users/sign_in')
				end

				it '個展編集画面に遷移できない' do
					visit edit_users_exhibition_path(exhibition)
					expect(current_path).to eq('/users/sign_in')
				end

				it 'ユーザー編集画面に遷移できない' do
					visit edit_users_user_path(user)
					expect(current_path).to eq('/users/sign_in')
				end

				it 'ギャラリー作成画面に遷移できない' do
					visit new_users_gallery_path
					expect(current_path).to eq('/users/sign_in')
				end

				it 'ギャラリー編集画面に遷移できない' do
					visit edit_users_gallery_path(user)
					expect(current_path).to eq('/users/sign_in')
				end
			end
		end
	end



