class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:optional_id]
  # User登録後にwelcomeメールを送信
  after_create :send_welcome_mail


  # optional_idでユーザーを判別するため、明示する
  validates_uniqueness_of :optional_id
  validates_presence_of :optional_id

  # 通常のバリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :optional_id, format: { with: /\A[a-zA-Z0-9]+\z/, message: "半角英数字のみが使えます" }, length: { minimum: 8, maximum: 20 }
  validates :introduction, length: { minimum: 10, maximum: 200, message: "10字以上200字以内で記入してください" }, if: :allow_empty_string?

  # frendly_id のための 設定項目
  include FriendlyId
  friendly_id :optional_id

  # carrierwave のため 設定項目
  mount_uploader :avatar, AvatarUploader

  has_many :expressions, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participated_events, through: :participations, source: :event
  has_many :checks, dependent: :destroy
  has_many :checked_arguments, through: :checks, source: :argument
  has_many :components, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # フォロー機能（トラスト機能）に使用
  has_many :relationships
  has_many :trustings, through: :relationships, source: :trust
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'trust_id'
  has_many :trusteds, through: :reverse_of_relationships, source: :user

  # DM機能に使用
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # deviseオーバーライド / 論理削除用
  def active_for_authentication?
    super && (is_valid == true)
  end

  def send_welcome_mail
    UserMailer.welcome_mail(self).deliver_now
  end

  # フォロー機能 (トラスト機能)関連のメソッド
  def trust(other_user)
    unless self == other_user
      relationships.find_or_create_by(trust_id: other_user.id)
    end
  end

  def untrust(other_user)
    relationship = relationships.find_by(trust_id: other_user.id)
    relationship.destroy if relationship
  end

  def trusting?(other_user)
    trustings.include?(other_user)
  end

  # チェック機能の有無を確認する
  def checked?(argument)
    checks.exists?(argument_id: argument.id)
  end

  def participated?(event)
    participations.exists?(event_id: event.id)
  end

  private

  def allow_empty_string?
    introduction.present?
  end
end
