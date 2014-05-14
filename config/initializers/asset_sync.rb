# Since this gem is only loaded with the assets group, we have to check to
# see if it's defined before configuring it.
if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = ENV['FOG_PROVIDER']
    config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    config.fog_directory = ENV['FOG_DIRECTORY']
    config.fog_region = 'eu-west-1'

    config.existing_remote_files = 'delete'

    # Fail silently.  Useful for environments such as Heroku
    config.fail_silently = true
  end
end
