require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'ユーザー管理機能' do
    before do
      
    end
    context 'ユーザー登録をしたら' do
      it 'タスク一覧画面にユーザーの名前が表示される' do
        visit new_user_path
        fill_in '名前', with: "user1"
        fill_in 'メールアドレス', with: "user1@xxx.com"
        fill_in 'パスワード', with: "qqqqqqqq"
        fill_in '確認用パスワード', with: "qqqqqqqq"
        click_button 'Create my account'
        expect(page).to have_content "user1"
        expect(page).to have_current_path tasks_path
        
      end
    end
    context 'ユーザー登録をしたら' do
      it 'タスク一覧画面にユーザーの名前が表示される' do
        visit tasks_path
        expect(page).to have_current_path new_session_path
        
      end
    end
  end
  describe 'セッション機能' do
    # before do
    #   admin=FactoryBot.create(:admin_user) 
    #   user1=FactoryBot.create(:user) 
    #   user2=FactoryBot.create(:user) 
    # end
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    context '該当メールアドレスとパスワードを入力したら' do
      it 'ログインできる' do
        visit new_session_path
        fill_in 'Email', with: "user1@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        expect(page).to have_content "user1"
        # expect(page).to have_current_path new_session_path
        expect(page).not_to have_current_path new_session_path
      end
    end
    context 'ログインしたら' do
      it '詳細画面に遷移ことができる' do
        visit new_session_path
        fill_in 'Email', with: "user1@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit user_path(user1.id)
        expect(page).to have_current_path user_path(user1.id)
        
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移すること' do
        visit new_session_path
        fill_in 'Email', with: "user1@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit user_path(user2.id)
        expect(page).to have_current_path tasks_path
        expect(page).not_to have_current_path user_path(user2.id)
      end
    end
    context 'ログアウトボタンを押すと' do
      it 'ログアウトすることができる' do
        visit new_session_path
        fill_in 'Email', with: "user1@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        click_link 'ログアウト'
        visit tasks_path
        expect(page).to have_current_path new_session_path
        expect(page).not_to have_current_path tasks_path
        
      end
    end
  end
  describe '管理画面' do
    before do
    end
    let!(:admin_user){FactoryBot.create(:admin_user)}
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    context '管理者権限があれば' do
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'Email', with: "admin@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_current_path admin_users_path
      end
    end
    context '管理者権限があれば' do
      it '管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'Email', with: "user1@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit admin_users_path
        expect(page).not_to have_current_path admin_users_path
      end
    end
    context '管理者権限があれば' do
      it '新しいユーザーを登録できる' do
        visit new_session_path
        fill_in 'Email', with: "admin@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit new_admin_user_path
        fill_in '名前', with: "new_user"
        fill_in 'メールアドレス', with: "new_user@xxx.com"
        fill_in 'パスワード', with: "qqqqqqqq"
        fill_in '確認用パスワード', with: "qqqqqqqq"
        click_button '新規登録'
        visit admin_users_path
        expect(page).to have_content "new_user"
        
      end
    end
    context '管理者権限があれば' do
      it 'ユーザーの詳細画面にアクセスできる' do
        visit new_session_path
        fill_in 'Email', with: "admin@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit user_path(user1.id)
        expect(page).to have_content "user1さん"
        visit user_path(user2.id)
        expect(page).to have_content "user2さん"
        
        
      end
    end
    context '管理者権限があれば' do
      it '編集画面で編集できる' do
        visit new_session_path
        fill_in 'Email', with: "admin@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit edit_admin_user_path(user1.id)
        fill_in '名前', with: "edit_user"
        fill_in 'メールアドレス', with: "user1@xxx.com"
        fill_in 'パスワード', with: "qqqqqqqq"
        fill_in '確認用パスワード', with: "qqqqqqqq"
        click_button '編集する'
        
        
      end
    end
    context '管理者権限があれば' do
      it 'ユーザーを削除することができる' do
        visit new_session_path
        fill_in 'Email', with: "admin@xxx.com"
        fill_in 'Password', with: "qqqqqqqq"
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content "user1"
        
        all('tbody tr')[1].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "user1"
        
      end
    end
  end
  
end