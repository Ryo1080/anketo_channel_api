CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                                      # required
    aws_access_key_id:     'AKIARKME5KIMI27WD6JA',                     # required unless using use_iam_profile
    aws_secret_access_key: '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', # required unless using use_iam_profile
    region:                'ap-northeast-1',                           # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'anketo-channel-s3'                          # required
end
