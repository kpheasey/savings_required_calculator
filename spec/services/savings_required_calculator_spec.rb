require 'rails_helper'

Rspec.describe SavingsRequiredCalculator do

  let!(:src) do
    SavingsRequiredCalculator.new(
        [{ age: 50, retirement_age: 62 }, { age: 41, retirement_age: 53 }],
        target_income: 20000.0,
        social_security: 4000.0,
        pensions: 3500.0,
        other_income: 0.0,
        avg_inflation_rate: 0.031,
        avg_rate_return: 0.05,
        current_portfolio: 2400000.0
    )
  end

  describe '#youngest_person_retirement_age' do
    it { expect(src.youngest_person_retirement_age).to eq 53 }
  end

  describe '#years_to_retirement' do
    it { expect(src.years_to_retirement).to eq 12 }
  end

  describe '#portfolio_after_growth' do
    it { expect(src.portfolio_after_growth).to eq nil }
  end

  describe '#withdrawal_rate' do
    it { expect(src.withdrawal_rate).to eq nil }
  end

  describe '#adjusted_target_income' do
    it { expect(src.adjusted_target_income).to eq nil }
  end

  describe '#savings_portion_needed' do
    it { expect(src.savings_portion_needed).to eq nil }
  end

  describe '#annualized_portfolio_amount_needed' do
    it { expect(src.annualized_portfolio_amount_needed).to eq nil }
  end

  describe '#recommended_min_portfolio' do
    it { expect(src.recommended_min_portfolio).to eq nil }
  end

  describe '#needed_amount_less_savings' do
    it { expect(src.needed_amount_less_savings).to eq nil }
  end

  describe '#required_annual_savings' do
    it { expect(src.required_annual_savings).to eq nil }
  end

  describe '#shortfall_excess' do
    it { expect(src.shortfall_excess).to eq nil }
  end

end