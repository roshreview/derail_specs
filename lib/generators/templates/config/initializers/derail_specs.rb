return unless Rails.env.test?

DerailSpecs.configure do |config|
  config.command = './tests.sh' # <-- delete this line for infinite mode
  config.host = '127.0.0.1'
  config.port = 3001
end
