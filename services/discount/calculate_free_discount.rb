# frozen_string_literal: true

class CalculateFreeDiscount
  def initialize(product, count, discount)
    @product = product
    @count = count
    @discount = discount
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    if @count > @discount.count
      batch_size = @discount.count + @discount.value

      value = (@count / batch_size) * (@discount.value * @product.price)

      @rest = @count % batch_size
      value += (@rest - @discount.count) * @product.price if @rest > 0
    end

    value
  end
end
