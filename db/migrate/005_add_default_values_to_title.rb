Sequel.migration do
  up do
    alter_table :entries do
      set_column_default :title, ''
    end
  end

  down do
    alter_table :entries do
      set_column_default :title, nil
    end
  end
end
