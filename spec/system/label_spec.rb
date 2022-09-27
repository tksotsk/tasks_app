require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do
  describe 'ラベル機能' do
    before do
      
      sample1=FactoryBot.create(:sample1) 
      sample2=FactoryBot.create(:sample2) 
      sample3=FactoryBot.create(:sample3) 
      sample4=FactoryBot.create(:sample4) 
      admin=FactoryBot.create(:admin_user) 
      user1=FactoryBot.create(:user1) 
      user2=FactoryBot.create(:user2)
      visit new_session_path
      fill_in 'Email', with: "user1@xxx.com"
      fill_in 'Password', with: "qqqqqqqq"
      click_button 'ログイン' 
    end
    context '新規登録するときに' do
      it 'ラベルの登録ができる' do
        visit new_task_path
        fill_in "タスクの名前", with: "task"
        fill_in "内容", with: "content"
        select "未着手", from: "task_status"
        check 'sample1'
        click_on "登録する"
        expect(page).to have_content "task"
        expect(page).to have_content "content"
        expect(page).to have_content "未着手"
        expect(page).to have_content "sample1"
      end
    end
    context '新規登録するときに' do
      it 'ラベルの登録ができる' do
        visit new_task_path
        fill_in "タスクの名前", with: "task"
        fill_in "内容", with: "content"
        select "未着手", from: "task_status"
        check 'sample1'
        click_on "登録する"
        visit tasks_path
        all('.tasks .task')[0].click_link 'タスクを編集する'
        uncheck 'sample1'
        check 'sample2'
        click_on "編集する"
        expect(page).to have_content "task"
        expect(page).to have_content "content"
        expect(page).to have_content "未着手"
        expect(page).not_to have_selector 'p', text: "sample1"
        expect(page).to have_selector 'p', text: "sample2"
        
      end
    end
  end
end