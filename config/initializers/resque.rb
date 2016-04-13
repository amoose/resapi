# Resque.redis = ENV['REDIS_HOST'] # default localhost:6379
# Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60) # 24hrs in seconds

Resque.redis = Redis.new