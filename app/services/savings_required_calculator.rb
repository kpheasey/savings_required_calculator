class SavingsRequiredCalculator

  attr_accessor :persons, :target_income, :social_security, :pensions, :other_income, :avg_inflation_rate,
                :avg_rate_return, :current_portfolio

  # @param persons [Array(Hash[:age, :retirement_age])]
  # @param options [Hash[:target_income, :social_security, :pensions, :other_income, :avg_inflation_rate, :avg_rate_return, :current_portfolio]]
  def initialize(persons, options)
    @persons = persons
    @target_income = options[:target_income].to_f
    @social_security = options[:social_security].to_f
    @pensions = options[:pensions].to_f
    @other_income = options[:other_income].to_f
    @avg_inflation_rate = options[:avg_inflation_rate].to_f
    @avg_rate_return = options[:avg_rate_return].to_f
    @current_portfolio = options[:current_portfolio].to_f
  end

  # Get retirement_age for the youngest person
  #
  # @param [Integer]
  def youngest_person_retirement_age
    self.persons.min_by { |p| p[:age] }[:retirement_age]
  end

  # Determine the minimum years to retirement of all persons.
  #
  # @return [Integer]
  def years_to_retirement
    self.persons.map { |p| p[:retirement_age] - p[:age] }.min
  end

  # @return [Float]
  def portfolio_after_growth
    self.current_portfolio + (self.current_portfolio * (self.avg_rate_return *  years_to_retirement) )
  end

  # Get the withdrawal rate based on the youngest person
  #
  # @return [Float]
  def withdrawal_rate
    (youngest_person_retirement_age - 15.0) / 1000.0
  end

  # Determine target income at retirement adjusted for inflation.
  #
  # @return [Float]
  def adjusted_target_income
    (self.target_income * (years_to_retirement * self.avg_inflation_rate)) + self.target_income
  end

  # Portion needed from savings
  #
  # @return [Float]
  def savings_portion_needed
    adjusted_target_income - (self.social_security + self.pensions + self.other_income)
  end

  # Annualized amount needed from portfolio
  #
  # @return [Float]
  def annualized_portfolio_amount_needed
    savings_portion_needed * 12.0
  end

  # Recommended minimum portfolio at retirement
  #
  # @return [Float]
  def recommended_min_portfolio
    annualized_portfolio_amount_needed / withdrawal_rate
  end

  # Needed amount minus current savings
  #
  # @return [Float]
  def needed_amount_less_savings
    recommended_min_portfolio - portfolio_after_growth
  end

  # Annual savings to retire at expected year
  #
  # @return [Float]
  def required_annual_savings
    needed_amount_less_savings / years_to_retirement
  end

  # Shortfall or excess
  #
  # @return [Float]
  def shortfall_excess
    self.current_portfolio - recommended_min_portfolio
  end

end