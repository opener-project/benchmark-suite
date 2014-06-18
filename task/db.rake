namespace :db do
  migrations_dir = File.expand_path('../../db/migrate', __FILE__)

  desc 'Generates a new migration'
  task :migration, [:name] do |task, args|
    abort 'You must specify a migration name' unless args[:name]

    template = <<-EOF.strip
Sequel.migration do
  up do

  end

  down do

  end
end
    EOF

    name = Time.now.strftime("%Y%m%d%H%I%S_#{args[:name]}.rb")
    path = File.join(migrations_dir, name)

    File.open(path, 'w') do |handle|
      handle.write(template)
    end
  end

  desc 'Migrates the database'
  task :migrate, [:target] => :environment do |task, args|
    target = args[:target] ? args[:target].to_i : nil

    Sequel::Migrator.run(DB, migrations_dir, :target => target)
  end
end
