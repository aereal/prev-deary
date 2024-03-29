Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :name
      String :password_digest
      String :password_salt
    end
  end

  down do
    drop_table :users
  end
end
