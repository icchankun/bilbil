require 'rails_helper'

RSpec.describe "管理者専用画面E2Eテスト", type: :system do
  describe '管理者ログイン' do
    let(:admin) { create(:admin) }
    
    before do
      visit new_admin_session_path
    end
  
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/sign_in'
      end
      it 'メールアドレス入力フォームが表示される' do
        expect(page).to have_field 'admin[email]'
      end
      it 'パスワード入力フォームが表示される' do
        expect(page).to have_field 'admin[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログインする'
      end
    end
  
    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログインする'
      end
  
      it 'ログイン後のリダイレクト先が、管理者側のコンテンツ一覧画面になっている' do
        expect(current_path).to eq '/admin'
      end
    end
  
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログインする'
      end
  
      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end
end
