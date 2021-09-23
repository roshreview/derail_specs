module DerailSpecs
  class Server
    App = Rack::Builder.new do
      map "/reset-transaction" do
        run lambda { |_env|
          Transaction.reset
          [202, { "Content-Type" => "text/plain" }, ["Accepted"]]
        }
      end
      map "/factory-bot/create" do
        run lambda { |env|
          body = Rack::Request.new(env).body.gets
          object = FactoryBot.create(*JSON.parse(body))

          [202, { "Content-Type" => "application/json" }, [object.to_json]]
        }
      end
      map "/factory-bot/create-list" do
        run lambda { |env|
          body = Rack::Request.new(env).body.gets
          object = FactoryBot.create_list(*JSON.parse(body))

          [202, { "Content-Type" => "application/json" }, [object.to_json]]
        }
      end
      map "/" do
        run Rails.application
      end
    end
  end
end
