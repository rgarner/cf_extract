require 'spec_helper'

describe Award do
  describe "Persistence" do
    let(:award) { Award.new(value: 1000.00, url: 'http://somewhere', date: Date.today) }
    it "should save ok" do
      award.save.should be_true
    end
  end

  describe ".parse" do
    set(:file) { CfExtract::NoticesFile.new(read_test_file('notices_2011_01.xml')) }

    subject { Award.parse(file.real_award_nodes.first) }

    it { should be_an(Award) }
    its(:url) { should eql('http://www.contractsfinder.businesslink.gov.uk/Common/View%20Notice.aspx?NoticeId=418') }
    its(:value) { should eql(25460.00)}
    its(:date) { should eql(Date.civil(2010, 11, 29)) }
  end
end