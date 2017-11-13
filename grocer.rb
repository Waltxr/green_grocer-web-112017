def consolidate_cart(cart)
  consolidated_hash = {}

  cart.each do |element|
    element.each do |item, info|
        consolidated_hash[item] = info
        info[:count] ||=0
        info[:count] +=1
    end
  end

  return consolidated_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?("#{coupon[:item]} W/COUPON")
      cart["#{coupon[:item]} W/COUPON"][:count] +=1
    elsif cart.keys.include?(coupon[:item])
      cart["#{coupon[:item]} W/COUPON"] = {
        :price=>coupon[:cost],
        :clearance=>cart[coupon[:item]][:clearance],
        :count => 1
      }
    else
      return cart
    end
    cart[coupon[:item]][:count] -= coupon[:num]
  end

  return cart
end


def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      item[:price] = item[:price] - item[:price] * 0.2
    end
    
  end
end

def checkout(cart, coupons)
  # code here
end
