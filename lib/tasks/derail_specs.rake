namespace :derail_specs do
  task run: :environment do
    DerailSpecs::Boot.new.run
  end
end
