require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a valid factory" do
    expect(build(:user)).to be_valid
  end
end
