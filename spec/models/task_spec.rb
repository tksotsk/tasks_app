require 'rails_helper'
Task.delete_all
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
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
        task = Task.new(name: 'タスク', content: '内容', status: "未着手")
        expect(task).to be_valid
        task.valid?
        expect(task.errors[:name]).not_to be_present
        expect(task.errors[:content]).not_to be_present
      end
    end
  end
  describe '検索機能' do
    
    let!(:first_task) { FactoryBot.create(:first_task) }
    let!(:second_task) { FactoryBot.create(:second_task)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        
        binding.pry
        
        expect(Task.name_search('task')).to include(first_task)
        expect(Task.name_search('task')).not_to include(second_task)
        expect(Task.name_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      end
    end
  end
end