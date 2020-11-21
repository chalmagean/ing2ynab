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

  def to_s
    "#{date};#{details};#{debit};#{credit}"
  end
end
