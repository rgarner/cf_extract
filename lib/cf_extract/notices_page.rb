module CfExtract
  class NoticesPage
    def initialize(body)
      @doc = Nokogiri::HTML(body)
    end

    def notice_urls
      @doc.css('a.filetype-xml').map do |a_node|
        uri = URI(a_node['href'])
        uri.absolute? ? uri : URI(File.join(Importer::ROOT_SITE, uri.to_s))
      end
    end
  end
end