class CacheUpdaterJob < ApplicationJob
  require redis
  sidekiq_options queue: 'default'

  def perform
    communications = Communication.all.to_json

    json_data = { communications: communications }.to_json
    $redis.set(
      "communications",
      json_data
    )
  end
end
