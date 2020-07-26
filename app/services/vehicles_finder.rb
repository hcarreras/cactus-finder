class VehiclesFinder
  def execute
    Scrapers::Biltorvet.new.execute
  end
end
