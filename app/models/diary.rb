class Diary < ApplicationRecord
  belongs_to :user #一対多、ユーザの紐付け無しには保存できない
  
  validates :content, presence: true, length: { maximum: 255 }
end
