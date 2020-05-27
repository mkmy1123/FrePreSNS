class Component < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
  validates :kind_of, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 200 }
  

  enum kind_of: {
    仕事: 0,
    性別: 1,
    世代: 2,
    体質: 3,
    趣味: 4,
    技術: 5,
    宗教: 6,
    思想: 7,
    嗜好: 8,
    その他: 20,
  }

end
