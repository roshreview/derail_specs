module DerailSpecs
  class Transaction
    def self.instance
      @instance ||= new
    end

    def self.begin
      instance.begin
    end

    def begin
      @connections = gather_connections
      @connections.each do |connection|
        connection.begin_transaction joinable: false, _lazy: false
        connection.pool.lock_thread = true
      end

      # When connections are established in the future, begin a transaction too
      @connection_subscriber = ActiveSupport::Notifications.subscribe("!connection.active_record") do |_, _, _, _, payload|
        if payload.key?(:spec_name) && (spec_name = payload[:spec_name])
          setup_shared_connection_pool

          begin
            ActiveRecord::Base.connection_handler.retrieve_connection(spec_name)
          rescue ActiveRecord::ConnectionNotEstablished
            connection = nil
          end

          if connection && !@connections.include?(connection)
            connection.begin_transaction joinable: false, _lazy: false
            connection.pool.lock_thread = true
            @connections << connection
          end
        end
      end
    end

    def self.rollback
      instance.rollback
    end

    def rollback
      return unless @connections.present?

      ActiveSupport::Notifications.unsubscribe(@connection_subscriber) if @connection_subscriber

      @connections.each do |connection|
        connection.rollback_transaction if connection.transaction_open?
        connection.pool.lock_thread = false
      end
      @connections.clear

      ActiveRecord::Base.clear_active_connections!
    end

    def self.reset
      instance.reset
    end

    def reset
      rollback
      self.begin
    end

    def gather_connections
      setup_shared_connection_pool if ActiveRecord::VERSION::MAJOR >= 6

      ActiveRecord::Base.connection_handler.connection_pool_list.map(&:connection)
    end

    # Shares the writing connection pool with connections on
    # other handlers.
    #
    # In an application with a primary and replica the test fixtures
    # need to share a connection pool so that the reading connection
    # can see data in the open transaction on the writing connection.
    def setup_shared_connection_pool
      @legacy_saved_pool_configs ||= Hash.new { |hash, key| hash[key] = {} }
      @saved_pool_configs ||= Hash.new { |hash, key| hash[key] = {} }

      ActiveRecord::TestFixtures
        .instance_method(:setup_shared_connection_pool)
        .bind(self)
        .call
    end
  end
end
