class User < ApplicationRecord
    before_save { self.email.downcase! } #emailの大文字を小文字に変換
    validates :name, presence: true, length: { maximum: 30 } #nameは空を許さず30文字以内
    validates :email, presence: true, length: { maximum: 255 }, #emailは空を許さず、255文字以内
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, #入力されるメールアドレスが正しい形式か
                    uniqueness: { case_sensitive: false } #メールアドレスの重複を許さない
    
    has_secure_password #パスワード暗号化保存
end
