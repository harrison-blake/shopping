class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors_that_sell = []
    @vendors.each do |vendor|
      vendors_that_sell << vendor if vendor.sold_items.include?(item)
    end

    vendors_that_sell
  end

  def sorted_item_list
    names = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        names << item.name if !names.include?(item.name)
      end
    end

    names.sort
  end

  def overstocked_items
    overstocked = []
    total_inventory.each do |item, hash|
      overstocked << item if hash[:quantity] > 50 && hash[:vendors].length > 1
    end

    overstocked
  end

  def total_inventory
    get_items_point_to_hash.each do |item, hash|
      @vendors.each do |vendor|
        hash[:quantity] += vendor.check_stock(item)
        hash[:vendors] << vendor if vendor.check_stock(item) > 0
      end
    end
  end

  def get_items_point_to_hash
    get_unique_items.reduce({}) do |acc, item|
        acc[item] = {:quantity => 0, :vendors => []}
        acc
    end
  end

  def get_unique_items
    items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        items << item
      end
    end

    items.uniq
  end
end
