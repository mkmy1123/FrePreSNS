class Component < ApplicationRecord
  belongs_to :user

  enum kind_of: {
    仕事: 0,
    趣味: 1,
    技術: 2,
    宗教: 3,
    思想: 4,
    嗜好: 5,
    その他: 6,
  }
end
