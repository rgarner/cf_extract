module CfExtract
  class Importer
    SCHEME = 'http://'
    HOST = 'www.contractsfinder.businesslink.gov.uk'
    ROOT_SITE = SCHEME + HOST

    ALL_AVAILABLE_NOTICES = ROOT_SITE + '/data-feed.aspx?site=1000&lang=en'
    LAST_40_DAYS_NOTICES = ROOT_SITE + '/public_files/Notices/Recent/notices.xml'

    class << self
      ##
      # Import a single notice page (default to last 40 days)
      def import(url = URI.parse(LAST_40_DAYS_NOTICES))
        NoticesFile.new(CfExtract::HTTP.get_follow_redirect(url).body).tap do |file|
          file.awards.each do |award|
            unless award.save
              puts award.errors
            end
          end
        end
      end

      ##
      # Get all XML URLs from the notice page.  Import them.
      def import_all
        response = CfExtract::HTTP.get_follow_redirect(URI.parse(ALL_AVAILABLE_NOTICES))
        NoticesPage.new(response.body).tap do |page|
          page.notice_urls.each { |url| import(url) }
        end
      end
    end
  end
end
