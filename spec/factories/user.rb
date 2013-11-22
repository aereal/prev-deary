FactoryGirl.define do
  factory :user do
    name 'dankogai'
    password_salt { UserAuthenticator::SaltStrategy.generate }
    password_digest { UserAuthenticator::DigestStrategy.digest_for(salt: password_salt, password: password) }

    ignore do
      password 'kogaidan'
    end
  end
end
