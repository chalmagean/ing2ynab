class Transaction
  attr_accessor :details, :date, :debit, :credit

  def initialize(details: [], date: nil, debit: 0.0, credit: 0.0)
    @details = details
    @date = date
    @debit = debit
    @credit = credit
  end

  def self.from_data(row)
    date, _, desc, _, _, credit, _, debit = row

    new(
      date: Date.parse(date),
      details: [desc],
      credit: to_float(credit),
      debit: to_float(debit)
    )
  end

  def to_s
    [date, details.join("\n"), credit, debit].join(",")
  end

  private

    def self.to_float(str)
      return 0.0 if str.nil? || str.empty?

      str.gsub(/\./, "").gsub(/,/, ".").to_f
    end
end
