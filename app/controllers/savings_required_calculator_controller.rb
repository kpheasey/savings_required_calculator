class SavingsRequiredCalculatorController < ApplicationController

  def new
    @calculator = SavingsRequiredCalculator.new(
        [{ age: 50, retirement_age: 62 }, { age: 41, retirement_age: 53 }],
        {}
    )
  end

  def show
    @calculator = SavingsRequiredCalculator.new(
        [{ age: 50, retirement_age: 62 }, { age: 41, retirement_age: 53 }],
        calculator_params.symbolize_keys
    )
    @chart = LazyHighCharts::HighChart.new('column') do |f|
      f.title(text: 'Savings Calculator')
      f.series(name: 'Current Portfolio', data: [@calculator.current_portfolio])
      f.series(name: 'Recommended Minimum Portfolio at Retirement', data: [@calculator.recommended_min_portfolio])
      f.series(name: 'Excess or Shortfall', data: [@calculator.shortfall_excess])
      f.chart({defaultSeriesType: 'column'})
    end
  end

  protected

  def calculator_params
    params.require(:calculator).permit(
        :target_income, :social_security, :pensions, :other_income, :avg_inflation_rate,
        :avg_rate_return, :current_portfolio, persons: [:age, :retirement_age]
    )
  rescue ActionController::ParameterMissing
    nil
  end

end
