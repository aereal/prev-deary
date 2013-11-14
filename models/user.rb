require 'openssl'

class User < Sequel::Model
  class InvalidAuthority < ::StandardError; end

  def self.create_with_digest(**args)
    name, password = *args.values_at(:name, :password)
    salt = SecureRandom.urlsafe_base64(32)
    digest = OpenSSL::HMAC.hexdigest('sha256', salt, password)
    create(name: name, password_digest: digest, password_salt: salt)
  end

  def authenticate!(password)
    calculated_digest = OpenSSL::HMAC.hexdigest('sha256', self.password_salt, password)
    raise InvalidAuthority unless self.password_digest == calculated_digest
  end
end
