module FormHelper
  def setup_group(group)
    puts "--------- ITEMS --------- #{group.items.inspect}"
    puts "--------- COUNT --------- #{group.items.size}"
    items_needed = 3 - group.items.size
    items_needed.times { group.items.build }
    group
  end
end