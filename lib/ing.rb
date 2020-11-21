require "csv"
require "ing/transaction"

class Ing
  def initialize(file_name)
    @csv = CSV.read(file_name)
    @csv.shift
    @headers = ["Date", "Details", "Debit", "Credit"].join(",")
  end

  def csv
    return if transactions.empty?
    puts ([@headers] + transactions.map(&:to_s)).join("\n").chomp
  end

  def transactions
    footnote = false
    @csv.reduce([]) do |trsc, row|
      date, _, desc, _, _, credit, _, debit = row

      if date.nil? && footnote == false
        trsc.last.details << desc.gsub(/"/, "")
        trsc
      elsif parse_date(date).is_a?(Date)
        footnote = false
        trsc << Transaction.from_data(row)
      else
        footnote = true
        trsc
      end
    end
  end

  def parse_date(value, default = nil)
    Date.parse(value.to_s)
  rescue ArgumentError
    default
  end
end
