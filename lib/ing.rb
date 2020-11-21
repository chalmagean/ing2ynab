require "csv"
require "ing/transaction"

class Ing
  def initialize(file_name)
    @csv = CSV.read(file_name)
    @headers = @csv.shift
    @transactions = transactions
  end

  def csv
    return if @transactions.empty?
    puts (@headers + @transactions).map(&:to_s).join("\n").chomp
  end

  def transactions
    @csv.reduce([]) do |trsc, row|
      date, desc, credit, debit = row[0].split(";")

      if date.nil? || date.empty?
        trsc.last.details << desc
        trsc
      else
        trsc << Transaction.from_data(row[0])
      end
    end
  end
end
