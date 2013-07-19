key    = ENV['PUSHER_KEY']
secret = ENV['PUSHER_SECRET']
app_id = ENV['PUSHER_APP_ID']
url    = "http://#{key}:#{secret}@api.pusherapp.com/apps/#{app_id}"

Pusher.url = url
