require 'rails_helper'

describe VehiclesFinder, type: :service do
  it "calls biltorvet scapers" do
    biltorvet_double = instance_double(Scrapers::Biltorvet)
    allow(Scrapers::Biltorvet).to receive(:new).and_return(biltorvet_double)
    allow(biltorvet_double).to receive(:execute)

    VehiclesFinder.new.execute

    expect(Scrapers::Biltorvet).to have_received(:new)
    expect(biltorvet_double).to have_received(:execute)
  end
end
