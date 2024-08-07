# -*- coding:utf-8 -*-

# テナント
class Account < ApplicationRecord
  # ユーザモデル・クラス名が `User` でない場合は,
  # `config/initializers/sorcery.rb` ファイル内のクラス名を書き換えること.
  authenticates_with_sorcery!

  has_one :facebook, class_name: 'Connect::Facebook', dependent: :destroy
  has_one :google,   class_name: 'Connect::Google', dependent: :destroy

  # 'admin' account が client を所有する. (テナント扱い)
  # 通常, 開発者と一般ユーザで、アカウントをまったく分けたりはしない.
  has_many :clients
  
  before_validation :setup, on: :create

  #validates :identifier, presence: true, uniqueness: true
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true

  class << self
    # Sorcery `login()` から callback される.
    def authenticate provider_class, code, nonce
      yield provider_class.authenticate(code, nonce)
    end
  end # class << self


private

  def setup
    #self.identifier = SecureRandom.hex(8)
  end
end
