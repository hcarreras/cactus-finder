require 'rails_helper'

describe VehicleNotifier, type: :service do
  context "given a bunch of initialized vehicles" do
    context "when it contains new vehicle" do
      let(:existing_vehicle_attributes) do
        {
          title: "Cactus C4",
          location: "Copenhagen",
          web_source: "bilbasen"
        }
      end
      let!(:persisted_vehicle) { create(:vehicle, **existing_vehicle_attributes) }
      let!(:existing_vehicle) { build(:vehicle, **existing_vehicle_attributes) }
      let!(:new_vehicle) do
        build(:vehicle,
          title: "New Cactus C4",
          location: "Aarhus",
          web_source: "bilbasen")
      end
      let(:coming_vehicles){ [new_vehicle, existing_vehicle] }

      it "saves the new vehicles" do
        sms_sender_double = instance_double(SmsSender)
        allow(SmsSender).to receive(:new).and_return(sms_sender_double)
        allow(sms_sender_double).to receive(:send)

        service = VehicleNotifier.new(vehicles: coming_vehicles)

        expect{ service.execute }.to change{ Vehicle.count }.by(1)
      end

      it "sends a notification" do
        sms_sender_double = instance_double(SmsSender)
        allow(SmsSender).to receive(:new).and_return(sms_sender_double)
        allow(sms_sender_double).to receive(:send)

        service = VehicleNotifier.new(vehicles: coming_vehicles)
        service.execute

        expect(sms_sender_double).to have_received(:send)
      end
    end

    context "when the vehicles already exist" do
      let(:existing_vehicle_attributes) do
        {
          title: "Cactus C4",
          location: "Copenhagen",
          web_source: "bilbasen"
        }
      end
      let!(:persisted_vehicle) { create(:vehicle, **existing_vehicle_attributes) }
      let!(:existing_vehicle) { build(:vehicle, **existing_vehicle_attributes) }

      it "does not save them" do
        service = VehicleNotifier.new(vehicles: [existing_vehicle])

        expect{ service.execute }.to change{ Vehicle.count }.by(0)
      end

      it "does not send a notification" do
        allow(SmsSender).to receive(:new)

        service = VehicleNotifier.new(vehicles: [existing_vehicle])
        service.execute

        expect(SmsSender).to_not have_received(:new)
      end
    end
  end
end
