require 'rails_helper'
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
        task = Task.new(name: 'タスク', content: '内容')
        expect(task).to be_valid
        task.valid?
        expect(task.errors[:name]).not_to be_present
        expect(task.errors[:content]).not_to be_present
      end
    end
  end
end