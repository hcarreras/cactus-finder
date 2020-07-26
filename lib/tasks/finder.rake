desc "Finds new vehicles"
  namespace :vehicles do
    task find: :environment do
      VehiclesFinder.perform_later
    end
  end
end
