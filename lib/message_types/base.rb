module MessageTypes
  class Base
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def valid?
      !message.nil?
    end

    def accept(visitor)
      raise "Not yet implemented"
    end
  end
end
