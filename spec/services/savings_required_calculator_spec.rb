require 'rails_helper'

RSpec.describe SavingsRequiredCalculator do

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
    it { expect(src.portfolio_after_growth).to eq 3840000.0 }
  end

  describe '#withdrawal_rate' do
    it { expect(src.withdrawal_rate).to eq 0.038 }
  end

  describe '#adjusted_target_income' do
    it { expect(src.adjusted_target_income).to eq 27440.0 }
  end

  describe '#savings_portion_needed' do
    it { expect(src.savings_portion_needed).to eq 19940.0 }
  end

  describe '#annualized_portfolio_amount_needed' do
    it { expect(src.annualized_portfolio_amount_needed).to eq 239280.0 }
  end

  describe '#recommended_min_portfolio' do
    it { expect(src.recommended_min_portfolio.round(2)).to eq 6296842.11 }
  end

  describe '#needed_amount_less_savings' do
    it { expect(src.needed_amount_less_savings.round(2)).to eq 2456842.11 }
  end

  describe '#required_annual_savings' do
    it { expect(src.required_annual_savings.round(2)).to eq 204736.84 }
  end

  describe '#shortfall_excess' do
    it { expect(src.shortfall_excess.round(2)).to eq -3896842.11 }
  end

end