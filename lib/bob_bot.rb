require 'message_types'

class BobBot
  attr_reader :message_types

  def initialize(*message_types)
    @message_types = message_types
  end

  def self.default
    @bob_bot ||= new(
      MessageTypes::Question,
      MessageTypes::Yell,
      MessageTypes::Empty,
      MessageTypes::Anything
    )
  end

  def respond(text)
    message_types.each do |type|
      message = type.new(text)
      return message.accept(self) if message.valid?
    end
    raise "Can't respond to: #{text || 'nil'}"
  end

  def respond_to_question
    'Sure.'
  end

  def respond_to_yell
    'Woah, chill out!'
  end

  def respond_to_empty
    'Fine. Be that way!'
  end

  def respond_to_anything
    'Whatever.'
  end
end
