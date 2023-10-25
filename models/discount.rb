class Discount
  FREE = 'free'
  ABSOLUTE = 'absolute'
  PERCENT = 'percent'

  attr_reader :type, :count, :value

  def initialize(discount)
    @type = discount['type']
    @count = discount['count']
    @value = discount['value']
  end
end
