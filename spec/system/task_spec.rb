require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        
        visit new_task_path
        # expect(page).to have_content 'task'
        # expect(page).to have_content 'Task'
        # expect(page).to have_content 'Task_Failure'

        fill_in "Name", with: "task"
        fill_in "Content", with: "content"
        click_on "登録する"
        
        
        expect(page).to have_content "task"
        expect(page).to have_content "content"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:task)
        visit tasks_path
        for n in 1..3
          expect(page).to have_content "task#{n}"
          expect(page).to have_content "content#{n}"
        end
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        
        task=FactoryBot.create(:task)
        visit task_path(task.id)
        
        expect(page).to have_content "task"
        expect(page).to have_content "content"
        
       end
     end
  end
end