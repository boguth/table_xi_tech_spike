require_relative 'algorithms'
puts "Hi, welcome to Bo Guthrie's Table XI coding challenge."
puts "To continue, please enter the filepath of the menu you would like to test."
puts ""

input = gets.chomp

price_array = []
menu_items_array = []
IO.foreach(input) do |x|
  price_array << x.scan(/\d.+/)[0].to_f
  menu_items_array << x
end
menu_items_array = menu_items_array.drop(1)
target_price = price_array.delete_at(0)
subset_prices(price_array, target_price)

puts "Let's see what dishes add up to #{target_price}."
puts ""

sort_dinner_combos(@matched_prices, menu_items_array)
# https://www.youtube.com/watch?v=NdF1QDTRkck
  # http://stackoverflow.com/questions/4632322/finding-all-possible-combinations-of-numbers-to-reach-a-given-sum