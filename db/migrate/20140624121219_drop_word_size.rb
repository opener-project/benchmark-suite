Sequel.migration do
  up do
    alter_table :benchmarks do
      drop_column :words
    end
  end

  down do
    alter_table :benchmarks do
      add_column :words, Integer
    end
  end
end
