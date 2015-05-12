require "bundler/gem_tasks"
require "kwipper"

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec
  task default: :spec
rescue LoadError
end

namespace :generate do
  desc "generate a model file"
  task :model, :model_name do |t, args|
    raise ArgumentError, ":model arg required" if args[:model_name].to_s.empty?

    model_lower = Kwipper::Inflect.new(args[:model_name]).underscore

    File.open Kwipper.file("app/models/#{model_lower}.rb"), "w" do |f|
      f.write <<-RUBY
class #{args[:model_name]} < Model
  column :field1, :to_s
end
      RUBY
    end
  end
end

namespace :schema do
  desc "run the create_tables.sql file"
  task :create do
    file = Kwipper.file "db/create_tables.sql"
    Kwipper::Model.sql File.read file
  end

  desc "run the drop_tables.sql file"
  task :drop do
    puts "Are you sure you want to drop all tables?"
    answer = gets.chomp.downcase

    if %w[y yes].include? answer
      puts "Okie"
      file = Kwipper.file "db/drop_tables.sql"
      Kwipper::Model.sql File.read file
    end
  end
end