require "spec_helper"

describe Kwipper::Paginator do
  let(:user_class) { Kwipper::User }
  let(:paginator) { described_class.new user_class, path: '/test' }
  let(:page_count) { paginator.pages.size }

  context "#initialize" do
    it "sets @page to 1 if a lower value is given" do
      paginator = described_class.new user_class, page: 0

      expect(paginator.page).to be 1
    end

    it "sets @per to 1 if a lower value is given" do
      paginator = described_class.new user_class, per: 0

      expect(paginator.per).to be 1
    end

    it "sets @count to the count of the model class given" do
      expect(paginator.count).to be user_class.count
    end

    it "sets @from to the calculated offset" do
      paginator = described_class.new user_class, page: 7, per: 5

      expect(paginator.from).to be ((paginator.page - 1) * paginator.per) + 1
    end

    it "sets @to a value no higher than @count" do
      count = user_class.count
      paginator = described_class.new user_class, page: count + 100

      expect(paginator.to).to be count
    end
  end

  context "#get" do
    it "takes a select statement and adds limit and offset" do
      p = paginator
      sql = "SELECT * FROM users LIMIT 20 OFFSET 0"
      expect(user_class.db).to receive(:execute).with(sql).and_return []

      p.get "SELECT * FROM users"
    end

    it "returns an array of models limited to the @per" do
      models = paginator.get "SELECT * FROM users"

      expect(models.first).to be_a user_class
      expect(models.size).to be <= paginator.per
    end
  end

  context "#pages" do
    it "returns an array of Page structs" do
      expect(paginator.pages.first).to be_a described_class::Page
    end
  end
  
  context "#on_first_page?" do
    it "returns true when on page 1" do
      expect(paginator.on_first_page?).to be true
    end

    it "returns false when not on page 1" do
      paginator = described_class.new user_class, page: page_count
      expect(paginator.on_first_page?).to be false
    end
  end
  
  context "#on_last_page?" do
    it "returns true when on the last page is current" do
      paginator = described_class.new user_class, page: page_count
      expect(paginator.on_last_page?).to be true
    end

    it "returns false when the last page is not current" do
      paginator = described_class.new user_class, page: 1
      expect(paginator.on_last_page?).to be false
    end
  end
  
  context "#prev_page_path" do
    it "returns the path of the page previous to the current page" do
      paginator = described_class.new user_class, page: page_count
      pages = paginator.pages
      prev_page = pages[pages.size - 2]

      expect(paginator.prev_page_path).to eq prev_page.path
    end

    it "returns the path of the current page when on the first page" do
      expect(paginator.prev_page_path).to eq paginator.path
    end
  end
  
  context "#next_page_path" do
    it "returns the path of the page after the current page" do
      expect(paginator.next_page_path).to eq paginator.path + '?page=2'
    end

    it "returns the path of the last page when on the last page" do
      paginator = described_class.new user_class, page: page_count

      expect(paginator.next_page_path).to eq paginator.pages.last.path
    end
  end
  
  context "#current_page" do
    it "returns the current page" do
      current = paginator.pages.detect &:current?

      expect(paginator.current_page).to be current
    end
  end
end
