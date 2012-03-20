class Award
  include DataMapper::Resource

  property :id, Serial
  property :date, DateTime
  property :value, Decimal
end