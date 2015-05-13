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
  task :model, :name do |t, args|
    raise ArgumentError, ":name arg required" if args[:name].to_s.empty?
    file_name = Kwipper::Inflect.new(args[:name]).underscore

    File.open Kwipper.file("app/models/#{file_name}.rb"), "w" do |f|
      f.write <<-RUBY
module Kwipper
  class #{args[:name]} < Model
    column :field1, :to_s
  end
end
      RUBY
    end
  end

  desc "generate a controller file"
  task :controller, :name do |t, args|
    raise ArgumentError, ":name arg required" if args[:name].to_s.empty?
    file_name = Kwipper::Inflect.new(args[:name]).underscore

    File.open Kwipper.file("app/controllers/#{file_name}_controller.rb"), "w" do |f|
      f.write <<-RUBY
module Kwipper
  class #{args[:name]}Controller < Controller
    add_routes "GET /#{file_name}" => :index

    def index
      
    end
  end
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
    file = Kwipper.file "db/drop_tables.sql"
    Kwipper::Model.sql File.read file
  end
end