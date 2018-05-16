module ConversationUtils
  module_function

  def conversation_between(user, other)
    conversation = Conversation.where(originator: user, target: other).or(
      Conversation.where(originator: other, target: user)
    ).first
    conversation || Conversation.create(originator: user, target: other)
  end
end
