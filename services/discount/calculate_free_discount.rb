# frozen_string_literal: true

class CalculateFreeDiscount
  def initialize(product, count)
    @product = product
    @count = count
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    value = @product.free_gift * @product.price * 1 if @count > @product.count_discount

    value
  end
end
