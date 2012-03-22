require "spec_helper"

describe CfExtract::Importer do
  describe ".import" do
    before do
      Award.all.length.should == 0
      mock_http_response('notices_2011_01.xml')
      CfExtract::Importer.import
    end

    specify { Award.all.length.should == 1 }
  end
end