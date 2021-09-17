require_relative 'server'

module DerailSpecs
  class Boot
    def run
      DerailSpecs.hooks.run(:before_server_start)
      Transaction.begin
      set_exit_hooks!

      Server.new.tap(&:boot)

      if command.present?
        puts "Run: #{command}"
        system command
      else
        loop { sleep 60 }
      end
    end

    private

    def command
      DerailSpecs.configuration.command
    end

    def set_exit_hooks!
      at_exit do
        Transaction.rollback
        DerailSpecs.hooks.run(:before_server_stop)
      end
      Signal.trap("INT") do
        puts "Exiting derail_specs…"
        exit
      end
    end
  end
end
