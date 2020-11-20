require "test_helper"
require "csv"

describe Ing do
  describe ".run" do
    it "returns an empty list" do
      CSV.open("testing.csv", "w") { |csv| csv << [] }

      ing = Ing.new("testing.csv")
      _(ing.run).must_equal []
    end

    describe "when the file has transactions" do
      it "returns a list of transactions" do
        CSV.open("testing.csv", "w") do |csv|
          csv << ["Date;Description;Credit;Debit"]
          csv << ["01 noiembrie 2020;Desc1;123.91"]
          csv << [";Desc2"]
        end

        result = Ing.new("testing.csv").run
        assert_equal result.length, 1
        transaction = result.first
        assert_equal transaction.details, "Desc1Desc2"
        assert_equal transaction.date, Date.new(2020, 11, 1)
        assert_equal transaction.credit, 123.91
        assert_equal transaction.debit, 0.0
      end
    end
  end
end
