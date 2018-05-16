module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :username, :current_user

    def connect
      self.username = cookies.encrypted[:username]
      self.current_user = User.find_by(name: username)
      logger.add_tags 'ActionCable', username
    end
  end
end
