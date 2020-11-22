require "csv"
require "ing/transaction"

class Ing
  def initialize(file_name)
    @csv = CSV.read(file_name)
    @csv.shift
    @headers = ["Date", "Payee", "Memo", "Outflow", "Inflow"].join(";")
  end

  def csv
    return if transactions.empty?
    ([@headers] + transactions.map(&:to_s)).join("\n").chomp
  end

  def transactions
    footnote = false
    @csv.reduce([]) do |trsc, row|
      date, _, desc, _, _, credit, _, debit = row

      if date.nil? && footnote == false
        trsc.last[:desc] << "|#{parse_details(desc)}"
        trsc
      elsif parse_date(date).is_a?(Date)
        footnote = false
        trsc << {
          date: date,
          desc: desc,
          credit: credit,
          debit: debit
        }
      else
        footnote = true
        trsc
      end
    end.map do |item|
      Transaction.from_data(item)
    end
  end

  def parse_date(value, default = nil)
    Date.parse(value.to_s)
  rescue ArgumentError
    default
  end

  def parse_details(desc)
    desc.gsub(/"/, "")
  end
end
