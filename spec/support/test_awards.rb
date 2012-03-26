shared_examples "Test awards" do
  let(:award) { Award.new(value: 1000.00, url: 'http://somewhere', date: Date.civil(2011, 01, 20)) }
  let(:award2) { Award.new(value: 2000.00, url: 'http://somewhere2', date: Date.civil(2012, 01, 20)) }

  def save_awards
    award.save
    award2.save
  end
end