require 'monobank'
require 'dotenv'

Dotenv.load

def log_statement(statement)
  statement.attributes.map do |key, value|
    if key == 'time'
      Time.at(value.to_i)
    else
      value.gsub(/\s/, ' ')
    end
  end.join(';')
end

def fetch_year(year)
  result = (1..1).each_with_object([]) do |month_number, result|
    result << 
      Monobank.statement(
        token: ENV['MONO_TOKEN'], 
        account_id: ENV['MONO_ACCOUNT_ID'], 
        from: Time.gm(year, month_number,1, 0, 0, 0).to_i, 
        to: Time.gm(year, month_number,31, 23, 59, 59).to_i
      )    

      # sleep(60)
  end

  result.flatten
end



open('output.csv', 'w') do |file|
  write_header = true
  fetch_year(2022).each do |statement|
    if write_header
      file.write(statement.attributes.keys.join(';') + "\n")
      write_header = false
    end
    file.write(log_statement(statement) + "\n")
  end

end
