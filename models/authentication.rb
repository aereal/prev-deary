require 'openssl'
require 'securerandom'

class Authentication
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

  def self.new_from_password(password)
    salt = SaltStrategy.generate
    digest = DigestStrategy.digest_for(salt: salt, password: password)
    self.new(salt: salt, digest: digest)
  end

  attr_reader :salt, :digest

  def initialize(salt: SaltStrategy.generate, digest: '')
    @salt = salt
    @digest = digest
  end

  def authenticate(password)
    @digest == DigestStrategy.digest_for(salt: @salt, password: password)
  end

  def authenticate!(password)
    raise InvalidAuthentication unless authenticate(password)
    self
  end
end
