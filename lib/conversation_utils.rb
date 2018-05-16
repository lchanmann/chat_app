module ConversationUtils
  module_function

  def conversation_between(user, other)
    conversation = Conversation.where(originator: user, target: other).or(
      Conversation.where(originator: other, target: user)
    ).first
    conversation || Conversation.create(originator: user, target: other)
  end

  def conversations_for(user)
    Conversation.where(originator: user).or(
      Conversation.where(target: user)
    )
  end
end
