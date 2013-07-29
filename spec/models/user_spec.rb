require 'spec_helper'

describe User do
  it "can be created" do 
    user = FactoryGirl.create(:user)
    expect(User.all).to include(user)
  end
  it "cannot send messages without registering" do
    user = FactoryGirl.create(:user)
    expect(ability.cannot?(:create), Message.new).to be_true
  end

  it "can send a message once registered" do 
    user = FactoryGirl.create(:paid_user)
    expect(ability.cannot?(:create), Message.new).to be_false
  end
end
