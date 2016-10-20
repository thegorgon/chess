
RSpec::Matchers.define :match_positions do |expected|
  def positions(array)
    array.map { |position| Chess::Position.normalize(position) }
  end

  def display(array)
    "%w(#{positions(array).map(&:to_code).join(' ')})"
  end

  match do |actual|
    positions(actual).map(&:to_code).sort == positions(expected).map(&:to_code).sort
  end

  description do
    "match #{display(expected)}"
  end

  failure_message do |actual|
    "expected that #{display(actual)} would contain" \
      " the same elements as #{display(expected)}"
  end

  failure_message_when_negated do |actual|
    "expected that #{display(actual)} would not contain" \
      " the same elements as #{display(expected)}"
  end
end
