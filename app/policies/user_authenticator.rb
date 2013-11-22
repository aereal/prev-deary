require 'openssl'
require 'securerandom'

class UserAuthenticator
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

  def self.authenticate(user: nil, password: '')
    auth = Authentication.new(salt: user.password_salt, digest: user.password_digest)
    auth.authenticate(password)
  end

  def self.authenticate!(user: nil, password: '')
    auth = Authentication.new(salt: user.password_salt, digest: user.password_digest)
    auth.authenticate!(password)
  end
end
