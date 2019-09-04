class User < ApplicationRecord
  before_save { self.email.downcase! } #emailの大文字を小文字に変換
  validates :name, presence: true, length: { maximum: 30 } #nameは空を許さず30文字以内
  validates :email, presence: true, length: { maximum: 255 }, #emailは空を許さず、255文字以内
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, #入力されるメールアドレスが正しい形式か
                  uniqueness: { case_sensitive: false } #メールアドレスの重複を許さない
  
  has_secure_password #パスワード暗号化保存
  
  has_many :diaries #一対多
  has_many :relationships #user 1:多 relationships 自分がフォローしているUser
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id' #自分をフォローしているUser
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user #自分自身ではないか
      self.relationships.find_or_create_by(follow_id: other_user.id) #既にフォローされている場合にフォローが重複して保存されることがなくなる
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user) #含まれていればtrue
  end
  
  def feed_diaries
    Diary.where(user_id: self.following_ids + [self.id])
  end
end
