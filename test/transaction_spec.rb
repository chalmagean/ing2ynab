require "test_helper"

describe Transaction do
  describe ".from_data" do
    it "returns a new object" do
      source_row = [
        "01 octombrie 2020",
        nil,
        "Transfer Home'Bank|Beneficiar:John Doe|Banca:INGB CENTRALA",
        nil,
        nil,
        "123.00",
        nil,
        "231.12"
      ]
      result = Transaction.from_data(source_row)
      _(result).must_be_instance_of(Transaction)
      _(result.payee).must_equal "John Doe"
      _(result.memo).must_equal "Transfer Home'Bank"
    end
  end

  describe "#to_s" do
    it "returns a CSV row" do
      trs = Transaction.new(
        date: Date.new(2020, 11, 1),
        payee: "Google",
        memo: "Nothing",
        outflow: 1.0,
        inflow: 0.0
      )

      expected = "01/11/2020;Google;Nothing;1.0;0.0"
      _(trs.to_s).must_equal expected
    end
  end
end
