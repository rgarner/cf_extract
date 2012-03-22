require "spec_helper"

describe CfExtract::NoticesFile do
  describe ".new" do
    set(:file) { CfExtract::NoticesFile.new(read_test_file('notices_2011_01.xml')) }

    describe "The awards" do
      subject { file.awards }

      it { should have(1).award }
      specify { subject.each { |award| award.should be_an(Award) } }
    end


    describe "The notices" do
      subject { file.notices }

      it { should have(9).notices }
    end
  end
end