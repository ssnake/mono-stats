require 'monobank'
require 'dotenv'
require 'date'

Dotenv.load

def log_statement(statement, columns)
  columns.map do |column|
    value = statement.attributes[column].to_s

    if column == 'time'
      Time.at(value.to_i)
    elsif column == 'amount'
      value.to_i * -0.01
    else
      value.gsub(/\s/, ' ')
    end
  end.join(';')
end

def fetch_month(year, month)
  Monobank.statement(
    token: ENV['MONO_TOKEN'], 
    account_id: ENV['MONO_ACCOUNT_ID'], 
    from: Time.gm(year, month, 1, 0, 0, 0).to_i, 
    to: Time.gm(year, month, Date.new(year, month, -1).day, 23, 59, 59).to_i
  ) 
end

def year_to_csv(year)
  (1..12).each do |month|
    open("#{year}_#{month}_output.csv", 'w') do |file|
      puts "Fetching #{year} #{month}..."
      statements = fetch_month(year, month)
      
      columns = statements.map { |statement| statement.attributes.keys }.flatten.uniq
      
      file.write(columns.join(';') + "\n")

      statements.each do |statement|
        file.write(log_statement(statement, columns) + "\n")
      end
    end

    puts "Done. Sleeping..."
    sleep(60)
  end
  
end

year_to_csv(2022)

