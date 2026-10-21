require 'minitest/autorun'
require_relative 'solution'

class PasswordValidationTest < Minitest::Test
  PV = PasswordValidation

  def test_problem_example
    assert_equal %w[strong weak weak weak weak],
                 PV.password_strength(%w[iliketoCoDe teaMAKEsmehappy 123456789 xYz12 password],
                                      %w[coffee code happy])
  end

  def test_rules
    assert PV.weak?('Abc12', [])
    refute PV.weak?('Abc123', [])
    assert PV.weak?('123456', [])
    refute PV.weak?('12345a', [])
    assert PV.weak?('abcdefg', [])
    assert PV.weak?('ABCDEFG', [])
    refute PV.weak?('Abcdefg', [])
    assert PV.weak?('mycoffeecup1', ['coffee'])
    refute PV.weak?('myCoffeeCup', ['coffee'])
    refute PV.weak?('Abc123', [''])
  end
end
