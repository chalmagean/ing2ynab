require "test_helper"
require "csv"

describe Ing do
  describe ".csv" do
    it "doesn't print anything to the screen" do
      csv = CSV.open("test/tmp/testing.csv", "w") { |csv| csv << [] }

      assert_output("") { Ing.new("test/tmp/testing.csv").csv }
    end

    describe "when the file has transactions" do
      it "prints data in CSV format to the screen" do
        expected = <<~CSV
          Date,Details,Debit,Credit
          2020-10-01,Transfer Home'Bank\nBeneficiar:John Doe\nIn contul:RO25INGB0000999902411380\nBanca:INGB CENTRALA\nReferinta:411896011,2000.0,0.0
          2020-10-02,Cumparare POS\nNr. card:**** **** **** 1722\nTerminal:REVO*Superman LT GBR\n30-09-2020 Autorizare: 213164,400.0,0.0
          2020-10-03,Cumparare POS\nNr. card:**** **** **** 1112\nTerminal:Patreon* Membership IE INTERNET\n01-10-2020 Autorizare: 531271\nSuma:11,90 USD\n10,16 EUR Rata ING: 4.896,49.74,0.0
          2020-10-07,Cumparare POS\nNr. card:**** **** **** 1122\nTerminal:HBO EUROPE SRO CZ\n05-10-2020 Autorizare: 000808\nSuma:3,99 EUR\n3,99 EUR Rata ING: 4.9046,9.57,0.0
          2020-10-12,Transfer Home'Bank\nBeneficiar:God\nIn contul:RO14INGB000092190461816\nBanca:INGB CENTRALA\nDetalii:none\nReferinta:415815854,58.0,0.0
        CSV
        assert_output(expected) { Ing.new("test/fixtures/ing_export.csv").csv }
      end
    end
  end
end
