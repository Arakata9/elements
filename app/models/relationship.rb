class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' #User クラスを参照する
end
