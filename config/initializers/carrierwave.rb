CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                   => 'AWS',
    :aws_access_key_id          => "AKIAI4PFY5SQJCS2MFRA",
    :aws_secret_access_key      => "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"
}
  config.fog_directory = "strobehub"
end
