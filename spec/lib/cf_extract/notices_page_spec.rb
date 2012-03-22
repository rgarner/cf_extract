require "spec_helper"

describe CfExtract::NoticesPage do
  describe ".new" do
    set(:page) { CfExtract::NoticesPage.new(File.read(test_file_name('notices-page.html'))) }

    describe "The notices" do
      subject { page }

      it { should have(7).notice_urls }
    end

    describe "A notice url" do
      subject { page.notice_urls.first }

      it { should be_a(URI::HTTP) }
      it { should be_absolute }
    end
  end
end