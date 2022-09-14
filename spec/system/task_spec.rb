require 'rails_helper'
Task.delete_all
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        
        visit new_task_path
        # expect(page).to have_content 'task'
        # expect(page).to have_content 'Task'
        # expect(page).to have_content 'Task_Failure'
        
        
        fill_in "タスクの名前", with: "task"
        fill_in "内容", with: "content"
        select "未着手", from: "task_status"
        click_on "登録する"
        expect(page).to have_content "task"
        expect(page).to have_content "content"
        expect(page).to have_content "未着手"
      end
    end
  end
  describe '一覧表示機能' do
    # let!(:task){FactoryBot.create(:task)}
    before do
      task1 = FactoryBot.create(:task1)
      task2 = FactoryBot.create(:task2)
      task3 = FactoryBot.create(:task3)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content "task1"
        expect(page).to have_content "content1"
        expect(page).to have_content "task2"
        expect(page).to have_content "content2"
        expect(page).to have_content "task3"
        expect(page).to have_content "content3"
      end
    end
    
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        
        # task_list=[]
        # tasks.each {|n| task_list.push(n[:name])}
        pass =all('.task_name_row')
        
        expect(pass[0]).to have_content "task3"
        expect(pass[1]).to have_content "task2"
        expect(pass[2]).to have_content "task1"
        
      end
    end
    
    context '終了期限のボタンをクリックした場合' do
      it '終了期限の近いタスクが一番上に表示される' do
        
        click_on I18n.t('tasks.index.limit')
        sleep 1.0
        pass =all('.task_name_row')
        expect(pass[0]).to have_content "task1"
        expect(pass[1]).to have_content "task2"
        expect(pass[2]).to have_content "task3"
        
      end
    end
    
    context '優先度のボタンをクリックした場合' do
      it '優先度の高いタスクが一番上に表示される' do
        
        click_on I18n.t('tasks.index.limit')
        sleep 1.0
        click_on I18n.t('tasks.index.priority')
        sleep 1.0
        pass =all('.task_name_row')
        expect(pass[0]).to have_content "task3"
        expect(pass[1]).to have_content "task2"
        expect(pass[2]).to have_content "task1"
      end
    end
    
  end
  
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        
        
        task=FactoryBot.create(:task1)
        visit task_path(task.id)
        
        expect(page).to have_content "task"
        expect(page).to have_content "content"
        
      end
    end
  end
  
  describe '検索機能' do
    before do
      
      task1 = FactoryBot.create(:task1)
      task2 = FactoryBot.create(:task2)
      task3 = FactoryBot.create(:task3)
      visit tasks_path
    end
    
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        expect(page).to have_content 'task1'
        expect(page).to have_content 'task3'
        fill_in "task[name]", with: "3"
        click_on "検索する"
        expect(page).not_to have_content 'task1'
        expect(page).to have_content 'task3'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(page).to have_content '着手中'
        select "着手中", from: "task[status]"
        click_on "検索する"
        expect(page).not_to have_content 'ステータス:未着手'
        expect(page).to have_content 'ステータス:着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(page).to have_content '未着手'
        expect(page).to have_content 'task1'
        expect(page).to have_content 'task3'
        fill_in "task[name]", with: "3"
        select "未着手", from: "task[status]"
        click_on "検索する"
        expect(page).not_to have_content 'task1'
        expect(page).to have_content '3'
        expect(page).not_to have_content 'ステータス:着手中'
        expect(page).to have_content 'ステータス:未着手'
      end
    end
  end
end