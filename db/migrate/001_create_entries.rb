Sequel.migration do
  up do
    create_table :entries do
      primary_key :id
      String :title
      Text :body
      Text :formatted_body
      String :path
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :entries
  end
end
