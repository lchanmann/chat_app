module MessageTypes
  class Question < Base
    def valid?
      super && message.end_with?("?")
    end

    def accept(visitor)
      visitor.respond_to_question
    end
  end
end
