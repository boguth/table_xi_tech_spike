#boop
@matched_prices = []
@call_count = 0
def subset_prices(prices, target, partial=[])
  current_total = partial.inject(:+)
  if current_total == target
    @matched_prices << partial
  end
  if current_total == nil
    current_total = 0
  end
  if current_total >= target
    return
  end
  prices.each_with_index do |price, index|
    remaining = prices.drop(index)
    subset_prices(remaining, target, partial + [price])
  end
end

def count_prices(prices)
  price_count = Hash.new 0
    prices.each do | price |
      if price_count[price.to_s]
        price_count[price.to_s] += 1
      else
        price_count[price.to_s] = 1
      end
    end
    price_count
end

def sort_dinner_combos(prices, menu)
  price_count_holder = []
  combos = []

  prices.each do |sub_price|
    price_count_holder << count_prices(sub_price)
  end

  price_count_holder.each do |price_counts|
   combos << count_items(menu, price_counts)
  end
   puts "The following combinations will add up to your target price:"
  format_results(combos)
end

def count_items(menu, price_counts)
  combos = []
  price_counts.each do |price, count|
    menu.each do |menu_item|
      if menu_item.include?(price)
        combos << count.to_s
        combos << menu_item
      end
    end
  end
  combos
end

def format_results(combos)
  combos.each do |combo|
    the_answer = ""
    combo.each_with_index do |amount_and_items, index|
      if index == 0
        the_answer = the_answer + "#{amount_and_items} x "
      end
      if index == 1
        the_answer = the_answer + "#{amount_and_items.gsub(/,.*/, '')}"
      end
      if index % 2 == 0  && index > 1
        the_answer = the_answer + "#{amount_and_items} x "
      end
      if index % 2 != 0  && index > 1
        the_answer = the_answer + "#{amount_and_items.gsub(/,.*/, '')}"
      end
    end
    if @call_count == 0
      puts the_answer
      @call_count += 1
    else
      puts "or \n"
      puts the_answer
      @call_count += 1
    end
  end
end