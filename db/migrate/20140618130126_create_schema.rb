Sequel.migration do
  up do
    create_table :benchmarks do
      primary_key :id

      String :group
      String :name
      String :version
      String :language

      Float :warmup
      Float :runtime

      Integer :iterations

      Float :iteration_time
      Float :iterations_per_second

      # Input information
      Integer :words
      Integer :bytes
      Integer :characters
      String  :encoding

      # Ruby info
      String :ruby_engine
      String :ruby_platform
      String :ruby_version
      String :jruby_version

      # System/CPU info
      String :cpu_name

      # RSS usage in bytes.
      Integer :rss_before
      Integer :rss_after

      Time :created_at
    end
  end

  down do
    drop_table :benchmarks
  end
end
