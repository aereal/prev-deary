Sequel.migration do
  up do
    alter_table :entries do
      set_column_not_null :title
      set_column_not_null :body
      set_column_not_null :formatted_body
      set_column_not_null :path
      set_column_not_null :created_at
      set_column_not_null :updated_at
    end
  end

  down do
    alter_table :entries do
      set_column_allow_null :title
      set_column_allow_null :body
      set_column_allow_null :formatted_body
      set_column_allow_null :path
      set_column_allow_null :created_at
      set_column_allow_null :updated_at
    end
  end
end
