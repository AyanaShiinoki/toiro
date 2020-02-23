require 'rails_helper'

	describe '管理者の権限テスト'  do
		let(:admin) { create(:admin) }
		let(:user) { create(:user) }
		let(:exhibition) { create(:exhibition) }
		describe 'ログインしていない場合' do
			context 'アクセス権限のテスト' do

				it '個展一覧画面に遷移できない' do
					visit admins_exhibitions_path
					expect(current_path).to eq('/admins/sign_in')
				end

				it '個展詳細画面に遷移できない' do
					visit admins_exhibition_path(exhibition)
					expect(current_path).to eq('/admins/sign_in')
				end

				it '個展編集画面に遷移できない' do
					visit edit_admins_exhibition_path(exhibition)
					expect(current_path).to eq('/admins/sign_in')
				end

				it 'ユーザー一覧画面に遷移できない' do
					visit admins_users_path
					expect(current_path).to eq('/admins/sign_in')
				end

				it 'ユーザー詳細画面に遷移できない' do
					visit admins_user_path(user)
					expect(current_path).to eq('/admins/sign_in')
				end

				it 'ユーザー編集画面に遷移できない' do
					visit edit_admins_user_path(user)
					expect(current_path).to eq('/admins/sign_in')
				end
			end
		end
	end
