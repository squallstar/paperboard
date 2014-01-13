namespace :update_production do

  desc "updates the application"
  task :current_environment do
    puts "You are running rake task in #{Rails.env} environment"
  end
end
