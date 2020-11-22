require "test_helper"
require "csv"

describe Ing do
  describe ".csv" do
    it "doesn't print anything to the screen" do
      csv = CSV.open("test/tmp/testing.csv", "w") { |csv| csv << [] }

      result = Ing.new("test/tmp/testing.csv").csv
      _(result).must_equal nil
    end

    describe "when the file has transactions" do
      it "prints data in CSV format to the screen" do
        expected = <<~CSV
          Date;Payee;Memo;Outflow;Inflow
          01/10/2020;John Doe;Transfer Home'Bank;2000.0;0.0
          02/10/2020;REVO*Superman LT GBR;Cumparare POS;400.0;0.0
          03/10/2020;Patreon* Membership IE INTERNET;Cumparare POS;49.74;0.0
          07/10/2020;HBO EUROPE SRO CZ;Cumparare POS;9.57;0.0
          12/10/2020;God;Transfer Home'Bank;58.0;0.0
          28/10/2020;Batman;Incasare;0.0;500.0
        CSV
        result = Ing.new("test/fixtures/ing_export.csv").csv
        _(result).must_equal expected.chomp
      end
    end
  end
end
