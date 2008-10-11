require File.dirname(__FILE__) + '/spec_helper'

describe "merb_hoptoad_notifier" do
  before(:each) do
    stub(Merb).env { :production }
    stub(Merb).root { Dir.tmpdir }
    @config = {:development=>{:api_key=>"ZOMGLOLROFLMAO"}, :production=>{:api_key=>"UBERSECRETSHIT"}, :test=>{:api_key=>"ZOMGLOLROFLMAO"}}
  end
  
  it "should define a constant" do
    HoptoadNotifier.should_not be_nil
  end
  
  describe ".configure" do
    before(:each) do
      stub(YAML).load_file(File.join(Merb.root / 'config' / 'hoptoad.yml')) { @config }
      HoptoadNotifier.configure
    end
    it "should know the api key after configuring" do
      HoptoadNotifier.api_key.should == 'UBERSECRETSHIT'
    end
  end
end