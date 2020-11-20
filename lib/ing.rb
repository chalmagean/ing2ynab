require "ruby_jard"
require "csv"

class Transaction
  attr_accessor :details, :date, :debit, :credit

  def initialize(details: "", date: nil, debit: 0.0, credit: 0.0)
    @details = details
    @date = date
    @debit = debit
    @credit = credit
  end

  def self.from_data(data)
    date, desc, credit, debit = data.split(";")
    new(
      date: Date.parse(date),
      details: desc,
      credit: credit&.empty? ? nil : credit.to_f,
      debit: debit&.empty? ? nil : debit.to_f
    )
  end
end

class Ing
  def initialize(file_name)
    @csv = CSV.read(file_name, headers: :first_row, return_headers: false)
    @transactions = transactions
  end

  def run
    @transactions
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
