require_relative 'server'

module DerailSpecs
  class Boot
    def run
      Transaction.begin
      set_exit_hooks!

      Server.new.tap(&:boot)

      puts "Starting Tests…"

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
      end
      Signal.trap("INT") do
        puts "Exiting derail_specs…"
        exit
      end
    end
  end
end
