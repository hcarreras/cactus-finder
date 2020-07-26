require "sidekiq/web"

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(username, sidekiq_username) &
    ActiveSupport::SecurityUtils.secure_compare(password, sidekiq_password)
end
