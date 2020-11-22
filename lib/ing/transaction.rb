class Transaction
  PAYEE_REGEX = /(Beneficiar:|Terminal:)/
  FIELDS_SEPARATOR = "|"
  COLUMN_SEPARATOR = ";"

  attr_reader :date, :payee, :outflow, :inflow
  attr_accessor :memo

  def initialize(date:, payee:, outflow:, inflow:, memo: nil)
    @date = date
    @payee = payee
    @outflow = outflow
    @inflow = inflow
    @memo = memo
  end

  def self.from_data(row)
    payee, memo = parse_description(row[:desc])

    new(
      date: Date.parse(row[:date]),
      payee: payee,
      memo: memo,
      outflow: to_float(row[:credit]),
      inflow: to_float(row[:debit])
    )
  end

  def to_s
    [date.strftime("%d/%m/%Y"), payee, memo, outflow, inflow]
      .join(COLUMN_SEPARATOR)
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
