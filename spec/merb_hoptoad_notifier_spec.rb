require File.dirname(__FILE__) + '/spec_helper'

describe "merb_hoptoad_notifier" do
  it "should define a constant" do
    HoptoadNotifier.should_not be_nil
  end
end