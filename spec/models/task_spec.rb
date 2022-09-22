require 'rails_helper'
Task.delete_all
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    let!(:user) { FactoryBot.create(:user) }
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: '失敗テスト')
        expect(task).not_to be_valid
        task.valid?
        expect(task.errors[:name]).to be_present
      end
    end
      context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: 'タスク：失敗テスト', content: '')
        expect(task).not_to be_valid
        task.valid?
        expect(task.errors[:content]).to be_present
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        
        task = Task.new(name: 'タスク', content: '内容', status: "未着手", user_id: user.id)
        
        expect(task).to be_valid
        task.valid?
        expect(task.errors[:name]).not_to be_present
        expect(task.errors[:content]).not_to be_present
      end
    end
  end
  describe '検索機能' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:task1) { FactoryBot.create(:task1, user_id: user.id) }
    let!(:task2) { FactoryBot.create(:task2, user_id: user.id)}
    let!(:task3) { FactoryBot.create(:task3, user_id: user.id)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.name_search('task1')).to include(task1)
        expect(Task.name_search('task1')).not_to include(task2)
        expect(Task.name_search('task1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('着手中')).to include(task1)
        expect(Task.status_search('着手中')).not_to include(task2)
        expect(Task.status_search('着手中').count).to eq 1
        
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_search('task2').status_search('未着手')).to include(task2)
        expect(Task.name_search('task2').status_search('未着手')).not_to include(task1)
        expect(Task.name_search('task2').status_search('未着手')).not_to include(task3)
        expect(Task.name_search('task2').status_search('未着手').count).to eq 1
      end
    end
  end
end