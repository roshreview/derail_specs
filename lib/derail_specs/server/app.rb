module DerailSpecs
  class Server
    App = Rack::Builder.new do
      map "/reset-transaction" do
        run lambda { |_env|
          Transaction.reset
          [202, { "Content-Type" => "text/plain" }, ["Accepted"]]
        }
      end
      map "/" do
        run Rails.application
      end
    end
  end
end
