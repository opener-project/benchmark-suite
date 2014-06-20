Sequel.migration do
  up do
    alter_table :benchmarks do
      add_index :group
      add_index :name
      add_index :language
    end
  end

  down do
    alter_table :benchmarks do
      drop_index :group
      drop_index :name
      drop_index :language
    end
  end
end
