class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def stock(item, amount)
    if @inventory[item].nil?
      @inventory[item] = amount
    else
      @inventory[item] +=amount
    end
  end

  def check_stock(item)
    target = 0
    @inventory.each do |i, amount|
      target = amount if i == item
    end

    target
  end

  def sold_items
    @inventory.map do |item, amount|
      item
    end
  end

  def potential_revenue
    @inventory.sum do |item, amount|
      item.price[1..-1].to_f * amount
    end
  end
end
