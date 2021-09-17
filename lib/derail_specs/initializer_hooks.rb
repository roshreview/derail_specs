module DerailSpecs
  def self.hooks
    InitializerHooks.instance
  end

  class InitializerHooks
    def self.instance
      @instance ||= new
    end

    def before_server_start(&blk)
      register(:before_server_start, blk)
    end

    def before_server_stop(&blk)
      register(:before_server_stop, blk)
    end

    def reset!
      @hooks = {}
    end

    def run(name)
      return unless @hooks[name]

      @hooks[name].each(&:call)
    end

    private

    def register(name, blk)
      @hooks[name] ||= []
      @hooks[name] << blk
    end

    def initialize
      reset!
    end
  end
end
