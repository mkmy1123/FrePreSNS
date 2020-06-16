CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['ACCESS_KEY'],
      aws_secret_access_key: ENV['ACCESS_SECRET_KEY'],
      region: 'ap-northeast-1'
    }
    config.cache_storage = :fog

    # S3バケットを指定
    config.fog_directory  = ENV['S3_BUCKET']
  end
end

# 日本語入力を可能にするため。
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/