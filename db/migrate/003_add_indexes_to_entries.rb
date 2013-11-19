Sequel.migration do
  change do
    alter_table :entries do
      add_index :path, name: :entries_by_path, unique: true
      add_index :created_at, name: :entries_by_created_at
    end
  end
end
