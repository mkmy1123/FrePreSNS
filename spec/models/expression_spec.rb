require 'rails_helper'

RSpec.describe Expression, type: :model do
  pending "does not allow duplicate expression statement per user" do
    FactoryBot.create(:argument)
    expression = FactoryBot.build(:expression, statement: nil)
    expression.valid?
    expect(expression.errors[:statement]).to include("を入力してください")
  end
end
