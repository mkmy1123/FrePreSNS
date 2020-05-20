class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # carrierwave のため 設定項目
  mount_uploader :avatar, AvatarUploader

  has_many :expressions, dependent: :destroy
  has_many :checks, dependent: :destroy
  has_many :checked_arguments, through: :checks, source: :argument
  has_many :components, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # フォロー機能（トラスト機能）に使用
  has_many :relationships
  has_many :trustings, through: :relationships, source: :trust
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'trust_id'
  has_many :trusteds, through: :reverse_of_relationships, source: :user

  # フォロー関連のメソッド
  def trust(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(trust_id: other_user.id)
    end
  end

  def untrust(other_user)
    relationship = self.relationships.find_by(trust_id: other_user.id)
    relationship.destroy if relationship
  end

  def trusting?(other_user)
    self.trustings.include?(other_user)
  end

  # チェック機能の有無を確認する
  def checked?(argument)
    self.checks.exists?(argument_id: argument.id)
  end

end
