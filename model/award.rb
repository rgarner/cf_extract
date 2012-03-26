#encoding: utf-8
class Award
  include DataMapper::Resource

  property :id, Serial
  property :url, String, unique_index: true, required: true, length: 255
  property :date, DateTime, index: true, required: true
  property :value, Float, required: true

  validates_presence_of :url
  validates_uniqueness_of :url
  validates_presence_of :date, :value

  def to_s
    "#{date.strftime('%b %d %Y')} / £#{'%.2f' % value}"
  end

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
      Date.new(*(%w(YEAR MONTH DAY).map { |date_part| node.at_xpath(date_part).content.to_i }))
    end

    def for_year(year)
      raise ArgumentError, "for_year expects a year from 2011 onwards" unless year.is_a?(Fixnum) && year >= 2011
      lower, upper = Date.civil(year, 01, 01), Date.civil(year, 12, 31)
      Award.all(:date.gte => lower, :date.lte => upper, :order => [:date])
    end

    def years
      repository(:default).adapter.select(%(
        select year(date) year, count(*) award_count from awards group by year
        order by year desc
      ))
    end
  end
end