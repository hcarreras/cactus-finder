require 'rails_helper'

describe VehiclesFinder, type: :job do
  it "calls scapers and notifiers" do
    vehicles = build_list(:vehicle, 2)
    biltorvet_double = instance_double(Scrapers::Biltorvet)
    vehicles_notifier_double = instance_double(VehicleNotifier)

    allow(Scrapers::Biltorvet).to receive(:new).and_return(biltorvet_double)
    allow(biltorvet_double).to receive(:execute).and_return(vehicles)
    allow(VehicleNotifier).to receive(:new).and_return(vehicles_notifier_double)
    allow(vehicles_notifier_double).to receive(:execute)

    VehiclesFinder.new.perform_now

    expect(biltorvet_double).to have_received(:execute)
    expect(vehicles_notifier_double).to have_received(:execute)
  end
end
