Sequel.migration do
  change do
    alter_table :users do
      add_index :name, name: :unique_user_names, unique: true
    end
  end
end
