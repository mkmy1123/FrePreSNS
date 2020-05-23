class Component < ApplicationRecord
  belongs_to :user

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
