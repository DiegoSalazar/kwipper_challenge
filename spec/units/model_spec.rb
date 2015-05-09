require "spec_helper"

describe Kwipper::Model do
  before :all do
    Kwipper::User.create username: "test", email: "test@email.com", hashed_password: "123", created_at: Time.now
  end
  after(:all) { Kwipper::User.delete_all }

  let(:user_class) { Kwipper::User }
  let(:statement) { "SELECT * FROM users" }
  let(:existing_id) { user_class.all.last.id }

  context ".db" do
    it "opens a Postgres database and memoizes the value" do
      expect(described_class.db).to be_a PG::Connection
      expect(described_class.db.object_id).to be described_class.db.object_id
    end
  end

  context ".column" do
    it "adds an id column by default the first time its called" do
      expect(described_class.columns).to be nil
      described_class.column :name, :to_s # 

      expect(described_class.columns).to eq "id" => :to_i, :name => :to_s
    end

    it "adds the column name and type to the columns property" do
      described_class.column :name, :to_s

      expect(described_class.columns.keys.last).to be :name
    end

    it "creates attr accessors with the column name" do
      expect(described_class.new).to_not respond_to :test_attr
      described_class.column :test_attr, :to_s

      expect(described_class.new).to respond_to :test_attr      
    end
  end

  context ".sql" do
    it "executes the command in the database" do
      expect(described_class.db).to receive(:exec).with statement

      described_class.sql statement
    end

    it "returns raw results as an array of arrays" do
      results = described_class.sql statement

      expect(results.values).to be_an Array
      expect(results.values).to_not be_empty
    end

    it "raises a SQL error when an invalid statement is given" do
      expect { described_class.sql "nope" }.to raise_error PG::Error
    end
  end

  context ".all" do
    it "constructs a select statement and returns models" do
      models = user_class.all statement

      expect(models).to be_an Array
      expect(models.first).to be_a user_class
    end
  end

  context ".find" do
    it "returns a model from the database" do
      model = user_class.find existing_id # id of a user from the kwipper db

      expect(model).to be_a user_class
    end

    it "returns nil if nothing found" do
      model = user_class.find 0

      expect(model).to be nil
    end
  end

  context ".where" do
    it "constructs a sql statement with a where clause and returns models" do
      sql_where = "SELECT * FROM users WHERE email='wall@ea.com'"
      expect(user_class.db).to receive(:exec).with(sql_where).and_return []

      models = user_class.where email: "wall@ea.com"

      expect(models).to be_an Array
    end
  end

  context ".create" do
    it "constructs an insert statement" do
      sql_insert = "INSERT INTO users (email) VALUES('test@test.com') RETURNING id"
      expect(user_class.db).to receive(:exec).with sql_insert

      user_class.create email: 'test@test.com'
    end

    it "returns the created model" do
      model = user_class.create email: "test2@test.com", username: "test2", hashed_password: "123", created_at: Time.now

      expect(model).to be_a user_class
      expect(model.id).to be user_class.all.last.id
      expect(model.email).to eq "test2@test.com"
      expect(model.username).to eq "test2"
    end
  end

  context ".update" do
    let(:sql) { "UPDATE users SET email='test@update.com' WHERE id=3" }

    it "constructs and executes an update statement" do
      expect(user_class.db).to receive(:exec).with sql

      user_class.update 3, email: "test@update.com"
    end
  end

  context ".destroy" do
    let(:sql) { "DELETE FROM users WHERE id=3" }

    it "constructs and executes a delete statement" do
      expect(user_class.db).to receive(:exec).with sql

      user_class.destroy 3
    end
  end

  context ".exists?" do
    it "constructs a select statement with where clause" do
      id = existing_id
      sql = "SELECT id FROM users WHERE id = #{id} LIMIT 1"
      expect(user_class.db).to receive(:exec).with(sql).and_return []

      user_class.exists? id
    end

    it "returns true when there are is a result" do
      expect(user_class.exists? existing_id).to be true
    end

    it "returns false when there is no result" do
      expect(user_class.exists? 0).to be false
    end
  end

  context ".count" do
    it "returns the number of records given by the SQL statement" do
      expect(user_class.count).to be_a Fixnum
    end
  end

  context "#save" do
    it "updates the record if it already exists" do
      user = user_class.new id: existing_id, email: "testingsave@testing.com"
      user.save
      user = user_class.find existing_id

      expect(user.email).to eq "testingsave@testing.com"
    end

    it "creates a new record if it doesn't exist" do
      t = Time.now
      sql = "INSERT INTO users (email, created_at) VALUES('testingsavenew@testing.com', '#{t}') RETURNING id"
      user = user_class.new email: "testingsavenew@testing.com", created_at: t

      expect(user_class.db).to receive(:exec).with sql

      user.save
    end

    it "returns true when the SQL executed correctly" do
      user = user_class.new id: existing_id, email: "testingsave@testing.com"
      
      expect(user.save).to be true
    end

    it "returns false when there was a SQL error" do
      # TODO: the model is ignoring the return values of the inner create or update calls
      # and always returning true since it constructs a valid SQL statement. Find a way to have
      # it return false when an update doesn't find the ID to update.
    end
  end

  context "#update" do
    it "constructs an update statement for itself" do
      user = user_class.find existing_id
      email = "testingupdate-#{Time.now.to_i}@test.com"
      sql = "UPDATE users SET email='#{email}' WHERE id=#{user.id}"

      expect(user_class.db).to receive(:exec).with sql

      user.update email: email
    end

    it "returns true when the update was successful" do
      user = user_class.find existing_id
      email = "testingupdate-#{Time.now.to_i}@test.com"
      sql = "UPDATE users SET email='#{email}' WHERE id=#{user.id}"

      result = user.update email: email

      expect(result).to be true
    end

    it "returns false if an unknown attribute was passed in" do
      user = user_class.find existing_id
      email = "testingupdate-#{Time.now.to_i}@test.com"
      sql = "UPDATE users SET email='#{email}' WHERE id=#{user.id}"

      result = user.update nope: 'wat'

      expect(result).to be false
    end
  end

  context "#destroy" do
    it "constructs a delete statement for itself" do
      user = user_class.find existing_id
      sql = "DELETE FROM users WHERE id=#{user.id}"
      expect(user_class.db).to receive(:exec).with sql

      user.destroy
    end
  end
end
