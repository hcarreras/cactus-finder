require 'rails_helper'

describe Scrapers::Biltorvet, type: :service do
  describe "execute" do
    it "returns a list of vehicles" do
      browser_double = double("browser", goto: true, button: double("button", click: true))
      allow(browser_double).to receive(:html).and_return(File.open("#{Rails.root}/spec/fixtures/biltorvet.html"))
      allow(Watir::Browser).to receive(:new).and_return(browser_double)

      result = Scrapers::Biltorvet.new.execute

      expect(result).to be_an_instance_of Array
      expect(result.first).to be_an_instance_of Vehicle
      expect(result.count).to eq(4)
    end

    it "calls the mapper" do
      mapper_double = instance_double(Scrapers::Biltorvet::Mapper)
      browser_double = double("browser", goto: true, button: double("button", click: true))
      allow(browser_double).to receive(:html).and_return(File.open("#{Rails.root}/spec/fixtures/biltorvet.html"))
      allow(Watir::Browser).to receive(:new).and_return(browser_double)
      allow(Scrapers::Biltorvet::Mapper).to receive(:new).and_return(mapper_double)
      allow(mapper_double).to receive(:title)
      allow(mapper_double).to receive(:location)

      result = Scrapers::Biltorvet.new.execute

      expect(mapper_double).to have_received(:title).exactly(4).times
      expect(mapper_double).to have_received(:location).exactly(4).times
    end
  end
end
