class UserAuthentication
  def self.authenticate(user: nil, password: '')
    auth = Authentication.new(salt: user.password_salt, digest: user.password_digest)
    auth.authenticate(password)
  end

  def self.authenticate!(user: nil, password: '')
    auth = Authentication.new(salt: user.password_salt, digest: user.password_digest)
    auth.authenticate!(password)
  end
end
