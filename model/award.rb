class Award
  include DataMapper::Resource

  property :id, Serial
  property :url, String, unique_index: true
  property :date, DateTime, index: true
  property :value, Decimal

  validates_presence_of :url
  validates_uniqueness_of :url
  validates_presence_of :date, :value

  class << self
    def parse(node)
      Award.new.tap do |award|
        award.url = node.at_xpath(
            './/CONTRACTING_AUTHORITY_INFORMATION//INTERNET_ADDRESSES_CONTRACT_AWARD//URL_GENERAL').content
        award.value = node.at_xpath('.//TOTAL_FINAL_VALUE//VALUE_COST').content.gsub(' ', '').to_f
        award.date = parse_date(node.at_xpath('.//CONTRACT_AWARD_DATE'))
      end
    end

    def parse_date(node)
      Date.new(*(%w(YEAR MONTH DAY).map {|date_part| node.at_xpath(date_part).content.to_i}))
    end
  end
end