module MessageTypes
  class Anything < Base
    def valid?
      super && true
    end

    def accept(visitor)
      visitor.respond_to_anything
    end
  end
end
