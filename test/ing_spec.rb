require "test_helper"
require "csv"

describe Ing do
  describe ".csv" do
    it "returns an empty string" do
      CSV.open("testing.csv", "w") { |csv| csv << [] }

      assert_output("") { Ing.new("testing.csv").csv }
    end

    describe "when the file has transactions" do
      it "outputs data in CSV format" do
        CSV.open("testing.csv", "w") do |csv|
          csv << ["Date;Description;Credit;Debit"]
          csv << ["01 noiembrie 2020;Desc1;123.91"]
          csv << [";Desc2"]
        end

        csv = <<~CSV
          Date;Description;Credit;Debit
          2020-11-01;Desc1Desc2;0.0;123.91
        CSV
        assert_output(csv) { Ing.new("testing.csv").csv }
      end
    end
  end
end
