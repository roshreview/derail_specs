namespace :derail_specs do
  task run: :environment do
    Rails.env = "test"
    DerailSpecs::Boot.new.run
  end
end
