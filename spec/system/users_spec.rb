require 'rails_helper'


RSpec.describe User, type: :system do


	describe 'ユーザー認証のテスト' do
		describe 'ユーザーの新規登録' do

			before do
				visit new_user_registration_path
			end

			context '新規登録画面に遷移' do
				it '新規登録に成功' do
			        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
			        fill_in 'user[email]', with: Faker::Internet.email
			        fill_in 'user[password]', with: 'Ayana-43'
			        fill_in 'user[password_confirmation]', with: 'Ayana-43'
			        click_button 'Sign up'
			        expect(current_path).to eq(root_path)
				end

				it '新規登録に失敗' do
			        fill_in 'user[name]', with: ''
			        fill_in 'user[email]', with: ''
			        fill_in 'user[password]', with: ''
			        fill_in 'user[password_confirmation]', with: ''
			        click_button 'Sign up'
			        expect(page).to have_content 'error'
				end
			end
		end

		describe 'ユーザーログイン' do
			let(:user) { create(:user) }
			before do
				visit new_user_session_path
			end
			context 'ログイン画面に遷移' do
				let(:user) { create(:user) }

				it 'ログインに成功' do
		        fill_in 'user[email]', with: user.email
		        fill_in 'user[password]', with: user.password
		        click_button 'Log in'
		        # 現在のページが特定のパスであることを検証
		        expect(current_path).to eq(root_path)
				end

				it 'ログインに失敗' do
		        fill_in 'user[email]', with: ''
		        fill_in 'user[password]', with: ''
		        click_button 'Log in'
		        # 現在のページが特定のパスであることを検証
		        expect(current_path).to eq(new_user_session_path)
				end
			end
		end
	end



end