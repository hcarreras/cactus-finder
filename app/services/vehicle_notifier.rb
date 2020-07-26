class VehicleNotifier
  attr_reader :vehicles

  def initialize(vehicles:)
    @vehicles = vehicles
  end

  def execute
    SmsSender.new.send if vehicles.map(&:save).any?
  end
end
