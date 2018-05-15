module MessageTypes
  class Empty < Base
    def valid?
      super && message.strip.empty?
    end

    def accept(visitor)
      visitor.respond_to_empty
    end
  end
end
