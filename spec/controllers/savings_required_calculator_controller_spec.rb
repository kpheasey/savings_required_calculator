require 'rails_helper'

RSpec.describe SavingsRequiredCalculatorController, type: :controller do

  let!(:params) do
    {
        calculator: {
            persons: [{ age: 50, retirement_age: 62 }, { age: 41, retirement_age: 53 }],
            target_income: 20000.0,
            social_security: 4000.0,
            pensions: 3500.0,
            other_income: 0.0,
            avg_inflation_rate: 0.031,
            avg_rate_return: 0.05,
            current_portfolio: 2400000.0,
        }
    }
  end

  it 'should permit params' do
    should permit(
               :target_income, :social_security, :pensions, :other_income, :avg_inflation_rate,
               :avg_rate_return, :current_portfolio, persons: [:age, :retirement_age]
           )
               .for(:show, params: params, verb: :get)
               .on(:calculator)
  end

  describe 'GET #show' do
    before { get :show, params: params }

    it { should render_template('show') }
    it { should render_template(partial: '_form') }
    it { expect(assigns(:calculator)).to be_a SavingsRequiredCalculator }
    it { expect(assigns(:chart)).to be_a LazyHighCharts::HighChart }
  end

  describe 'GET #new' do
    before { get :new }

    it { should render_template('new') }
    it { should render_template(partial: '_form') }
    it { expect(assigns(:calculator)).to be_a SavingsRequiredCalculator }
  end

end
