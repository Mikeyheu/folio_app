if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

if Rails.env.production?
	CarrierWave.configure do |config|
		config.storage = :fog
	    config.fog_credentials = {
	      :provider               => 'AWS',
	      :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
	      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
	    }
	    config.cache_dir = "#{Rails.root}/tmp/uploads"
	    config.fog_directory    = ENV['S3_BUCKET_NAME']
	    config.fog_public = false
	    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
	end
end