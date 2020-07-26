require 'rails_helper'

describe VehicleNotifier, type: :service do
  context "given a bunch of initialized vehicles" do
    context "when it contains new vehicle" do
      it "saves the new vehicles" do
        existing_vehicle_attributes = {
          title: "Cactus C4",
          location: "Copenhagen",
          web_source: "bilbasen"
        }
        persisted_vehicle = create(:vehicle, **existing_vehicle_attributes)
        existing_vehicle = build(:vehicle, **existing_vehicle_attributes)
        new_vehicle = build(:vehicle,
          title: "New Cactus C4",
          location: "Aarhus",
          web_source: "bilbasen")

        coming_vehicles = [new_vehicle, existing_vehicle]

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
