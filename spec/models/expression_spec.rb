require 'rails_helper'

RSpec.describe Expression, type: :model do
  it "does not allow duplicate expression statement per user" do
    user = User.create(
      name: "test",
      email: "test@test.com",
      optional_id: "test0001",
      password: "testtest",
      password_confirmation: "testtest",
    )
    user.expressions.create(argument_id: 1,statement: "Hello",)
    new_expression = user.expressions.build(argument_id: 1,statement: "Hello",)
    new_expression.valid?
    expect(new_expression.errors[:statement]).to include("はすでに存在します")
  end
end
