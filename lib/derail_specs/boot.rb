module DerailSpecs
  class Boot
    def run
      Transactions.begin
      Transactions.rollback
      Transactions.begin
      Transactions.rollback
      Transactions.begin
      Transactions.rollback
      set_exit_hooks!
      sleep 50
    end

    private

    def set_exit_hooks!
      at_exit do
        rollback_if_needed!
      end
      Signal.trap("INT") do
        puts "Exiting derail_specs…"
        exit
      end
    end

    def rollback_if_needed!
      @rollback_needed ||= true
      return unless @rollback_needed

      Transactions.rollback

      @rollback_needed = false
    end
  end
end
