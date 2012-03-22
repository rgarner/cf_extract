module CfExtract
  class NoticesFile
    attr_reader :doc

    def initialize(body)
      @doc = Nokogiri::XML(body.sub('xmlns="http://www.w3.org/2001/XMLSchema"', ''))
    end

    def notices
      @doc.search('//CONTRACT')
    end

    def awards
      @awards ||= real_award_nodes.map { |node| Award.parse(node) }
    end

    def real_award_nodes
      # Awards are only those with an award date. Despite AWARD being mentioned everybloodywhere.
      # Remember, kids: CF XML lies.
      @doc.xpath('//CONTRACT_AWARD[.//CONTRACT_AWARD_DATE]')
    end
  end
end