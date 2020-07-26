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
        service = VehicleNotifier.new(vehicles: coming_vehicles)

        expect{ service.execute }.to change{ Vehicle.count }.by(1)
      end

      it "sends a notification"
    end

    context "when the vehicles already exist" do
      it "does not save them"
      it "does not send a notification"
    end
  end
end
