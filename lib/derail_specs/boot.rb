module DerailSpecs
  class Boot
    def run
      Transaction.begin
      set_exit_hooks!
    end

    private

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
