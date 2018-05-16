module EncryptedCookiesStub
  def encrypted
    self
  end
end
ActionCable::Connection::TestRequest::CookiesStub.prepend(EncryptedCookiesStub)
