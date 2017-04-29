require 'rexml/document'
require 'date'

current_path = File.dirname(__FILE__)
file_name = current_path + '/my_expenses.xml'

#Only in coding UTF-8!!!
file = File.new(file_name, 'r:UTF-8')
begin
  doc = REXML::Document.new(file)
rescue REXML::ParseException => error
  puts 'XML file was filthy...'
  abort error.message
end
file.close

puts 'What we had buy?'
expense_text = STDIN.gets.chomp

puts 'How much we had spent?'
expense_amount = STDIN.gets.chomp.to_i

puts 'Write a date when we make a purchase \"DD.MM.YYYY\". (empty - current date)'
date_input = STDIN.gets.chomp

if date_input == ''
  expense_date = Date.today
else
  expense_date = Date.parse(date_input)
end

puts 'What category of our purchase?'
expense_category = STDIN.gets.chomp

expenses = doc.elements.find('expenses').first

expense = expenses.add_element 'expense', {'date' => expense_date.to_s,
                                           'category' => expense_category,
                                           'amount' => expense_amount}
expense.text = "\s\s" + expense_text

file = File.new(file_name, 'w:UTF-8')

doc.write(file, 2)

file.close

puts 'Data of purchase was  saved.'