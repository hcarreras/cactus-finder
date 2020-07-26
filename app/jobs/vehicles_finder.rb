class VehiclesFinder < ApplicationJob
  def perform
    vehicles = Scrapers::Biltorvet.new.execute
    return unless vehicles.any?

    VehicleNotifier.new(vehicles: vehicles).execute
  end
end
