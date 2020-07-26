class VehicleNotifier
  attr_reader :vehicles

  def initialize(vehicles:)
    @vehicles = vehicles
  end

  def execute
    vehicles.each(&:save)
    SmsSender.new.send
  end
end
