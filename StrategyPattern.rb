# Контекст визначає інтерфейс, що представляє інтерфейс для клієнтів
class Context
  # Контекст зберігає посилання на один із об'єктів Стратегії
  # Контекст не знає конкретного класса стратегії
  # Він повинен працювать зі всіма стратегіями через інтерфейс Стратегії
  # @return [Strategy]
  attr_writer :strategy

  # Зазвичай Контекст приймає стратегію через конструктор, а також надає сеттер для її зміни під час виконання
  # @param [Strategy] strategy
  def initialize(strategy)
    @strategy = strategy
  end

  # Зазвичай Контекст дозволяє замінити об'єкт Стратегії під час виконання
  # @param [Strategy] strategy
  def strategy=(strategy)
    @strategy = strategy
  end

  # Аби самостійно не реалізовувать множину версій алгоритма, Контекст делегує деяку роботу об'єкту Стратегії
  def do_some_business_logic
    # ...

    puts 'Context: Sorting data using the strategy (not sure how it\'ll do it)'
    result = @strategy.do_algorithm(%w[a b c d e])
    print result.join(',')

    # ...
  end
end

# Інтерфейс Стратегії оголошує операції, спільні для всіх підтримуючих версій деякого алгоритма
# Контекст використовує цей інтерфейс для виклику алгоритму, визначеного конкретними Стратегіями
# @abstract
class Strategy
  # @abstract
  # @param [Array] data
  def do_algorithm(_data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Конкретні Стратегії реалізують алгоритм, следуючи базовому інтерфейсу Стратегії
# Цей інтерфейс робить їх взаємнозамінюваними в Контексті

class ConcreteStrategyA < Strategy
  # @param [Array] data
  #
  # @return [Array]
  def do_algorithm(data)
    data.sort
  end
end

class ConcreteStrategyB < Strategy
  # @param [Array] data
  #
  # @return [Array]
  def do_algorithm(data)
    data.sort.reverse
  end
end

# Клієнтський код обирає конкретну стратегію і передає її в Контекст
# Клієнт повинен знати про відмінності між стратегіями щоб зробить првильний вибір

context = Context.new(ConcreteStrategyA.new)
puts 'Client: Strategy is set to normal sorting.'
context.do_some_business_logic
puts "\n\n"

puts 'Client: Strategy is set to reverse sorting.'
context.strategy = ConcreteStrategyB.new
context.do_some_business_logic
