Sequel.migration do
  up do
    alter_table :benchmarks do
      [:bytes, :characters, :encoding].each do |column|
        drop_column(column)
      end
    end
  end

  down do
    alter_table :benchmarks do
      add_column :bytes, Integer
      add_column :characters, Integer
      add_column :encoding, String
    end
  end
end
