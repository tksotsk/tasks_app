class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :status, presence: true
  scope :sort_created_at, -> { order(created_at: :desc) }
  scope :sort_limit, -> { order(limit: :desc).limit(5) }
  def ja_limit
    if self.limit
        l=self.limit
      a = "#{l.year}年#{l.month}月#{l.day}日"
      b = "#{l.hour}時#{l.min}分"
      sentence=a+b
    else
        sentence = "なし"
    end
    sentence
  end
  scope :name_search, -> (n){ where("name LIKE ?", "%"+n+"%") }
  scope :status_search, -> (n){ where(status: n) }

end
