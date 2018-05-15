module MessageTypes
  class Yell < Base
    def valid?
      super &&
        !message.strip.empty? &&
        message == message.upcase &&
        message != message.to_i.to_s
    end

    def accept(visitor)
      visitor.respond_to_yell
    end
  end
end
