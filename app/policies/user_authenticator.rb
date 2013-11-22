require 'openssl'
require 'securerandom'

class UserAuthenticator
  class InvalidAuthentication < ::StandardError; end

  module DigestStrategy
    ENCRYPT_METHOD = 'sha256'

    def digest_for(salt: '', password: '')
      OpenSSL::HMAC.hexdigest(ENCRYPT_METHOD, salt, password)
    end
    module_function :digest_for
  end

  module SaltStrategy
    def generate
      SecureRandom.urlsafe_base64(32)
    end
    module_function :generate
  end

  def self.authenticated?(user: user, password: '')
    digest = DigestStrategy.digest_for(salt: user.password_salt, password: password)
    user.password_digest == digest
  end

  def self.authenticate(user: nil, password: '')
    authenticated?(user: user, password: password) ? user : nil
  end

  def self.authenticate!(user: nil, password: '')
    self.authenticated?(user: user, password: password) ? user : (raise InvalidAuthentication)
  end
end
