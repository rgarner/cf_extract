require 'spec_helper'

describe Award do
  it "should save ok" do
    a = Award.new
    a.save.should be_true
  end

end