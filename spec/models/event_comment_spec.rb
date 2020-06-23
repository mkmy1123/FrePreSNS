require 'rails_helper'

RSpec.describe EventComment, type: :model do
  it "is valid with argument & user, and body" do
    expect(build(:event_comment)).to be_valid
  end
end
