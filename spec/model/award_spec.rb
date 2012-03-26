require 'spec_helper'

describe Award do
  include_examples "Test awards"

  describe "Persistence" do
    it "should save ok" do
      award.save.should be_true
    end
  end

  describe "Querying" do
    before { award.save; award2.save }

    describe "#for_year" do
      subject { Award.for_year(2011) }

      it { should have(1).award }
      its(:first) { should eql(award) }
    end

    describe ".years" do
      subject { Award.years }

      it { should have(2).years }

      describe "The first year (just a struct)" do
        subject { Award.years.first }

        its(:year) { should eql(2012) }
        its(:award_count) { should eql(1) }
      end
    end
  end

  describe ".parse" do
    set(:file) { CfExtract::NoticesFile.new(read_test_file('notices_2011_01.xml')) }

    subject { Award.parse(file.real_award_nodes.first) }

    it { should be_an(Award) }
    its(:url) { should eql('http://www.contractsfinder.businesslink.gov.uk/Common/View%20Notice.aspx?NoticeId=418') }
    its(:value) { should eql(25460.00) }
    its(:date) { should eql(Date.civil(2010, 11, 29)) }
  end
end