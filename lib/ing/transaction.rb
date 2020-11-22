class Transaction
  PAYEE_REGEX = /Beneficiar:/
  FIELDS_SEPARATOR = "|"

  attr_reader :date, :payee, :outflow, :inflow, :memo

  def initialize(date:, payee:, outflow:, inflow:, memo: nil)
    @date = date
    @payee = payee
    @outflow = outflow
    @inflow = inflow
    @memo = memo
  end

  def self.from_data(row)
    date, _, desc, _, _, credit, _, debit = row
    payee, memo = parse_description(desc)

    new(
      date: Date.parse(date),
      payee: payee,
      memo: memo,
      outflow: to_float(credit),
      inflow: to_float(debit)
    )
  end

  def to_s
    [date.strftime("%d/%m/%Y"), payee, memo, outflow, inflow].join(";")
  end

  private

    # Turns float strings from "2.000,12" to 2000.12
    def self.to_float(str)
      return 0.0 if str.nil? || str.empty?

      str.gsub(/\./, "").gsub(/,/, ".").to_f
    end

    def self.parse_description(desc)
      fields = desc.split(FIELDS_SEPARATOR)
      payee = fields.find { |el| el.match?(PAYEE_REGEX) }
      [payee.split(":").last, fields.first]
    end

end
