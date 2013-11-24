Sequel.migration do
  up do
    alter_table :users do
      set_column_not_null :name
      set_column_not_null :password_salt
      set_column_not_null :password_digest
    end
  end

  down do
    alter_table :users do
      set_column_allow_null :name
      set_column_allow_null :password_salt
      set_column_allow_null :password_digest
    end
  end
end
