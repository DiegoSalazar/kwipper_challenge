require "kwipper"

# Run with: ruby -r ./db/schema.rb -e schema_load
def schema_load
  schema_file = Kwipper.file "db", "create_tables.sql"
  Kwipper::Model.sql File.read schema_file
end
