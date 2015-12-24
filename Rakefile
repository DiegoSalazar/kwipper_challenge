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
    name = get_file_name args
    write_template "app/models/#{name}.rb", MODEL_TEMPLATE.call(args[:name])
  end

  desc "generate a controller file"
  task :controller, :name do |t, args|
    name = get_file_name args
    write_template "app/controllers/#{name}_controller.rb", CONTROLLER_TEMPLATE.call(args[:name], name)
  end

  desc "generate a spec file"
  task :spec, :name, :type do |t, args|
    name = get_file_name args    
    type = args[:type] || "units"
    write_template "spec/#{type}/#{name}_spec.rb", SPEC_TEMPLATE.call(args[:name])
  end
end

namespace :db do
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

  desc "dump database to the db directory"
  task do
    `pg_dump --inserts --data-only -d kwipper_development`
  end

  desc "run the sql dumpf ile"
  task :restore do
    file = Kwipper.file "db/kwipper.sql"
    Kwipper::Model.sql File.read file
  end
end

#
# Helpers
#

def write_template(path, template)
  File.open Kwipper.file(path), "w" do |f|
    f.write template
  end
end

def get_file_name(args)
  raise ArgumentError, ":name required" if args[:name].to_s.empty?
  Kwipper::Inflect.new(args[:name]).underscore
end

#
# Templates
#

MODEL_TEMPLATE = ->(name) {
<<-RUBY
module Kwipper
  class #{name} < Model
    column :field1, :to_s
  end
end
RUBY
}

CONTROLLER_TEMPLATE = ->(name, name_lower) {
<<-RUBY
module Kwipper
  class #{name}Controller < Controller
    add_routes "GET /#{name_lower}" => :index

    def index
      
    end
  end
end
RUBY
}

SPEC_TEMPLATE = ->(name) {
<<-RUBY
require "spec_helper"

describe Kwipper::#{name} do
  context "" do
    it ""
  end
end
RUBY
}