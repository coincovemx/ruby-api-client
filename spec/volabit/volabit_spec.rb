
require File.expand_path('spec/spec_helper')
require File.expand_path('lib/volabit')

PRODUCTION_URL = 'https://www.volabit.com'
SANDBOX_URL    = 'https://sandbox.volabit.com'

RSpec.describe Volabit do
  subject { described_class }

  it { should respond_to :site_for }

  it 'holds the constant for the production environment' do
    expect(subject::PRODUCTION_SITE).to be
    expect(subject::PRODUCTION_SITE).to eql PRODUCTION_URL
  end

  it 'holds the constant for the test environment' do
    expect(subject::SANDBOX_SITE).to be
    expect(subject::SANDBOX_SITE).to eql SANDBOX_URL
  end

  describe '.site_for' do
    context 'receiving "production"' do
      xit 'returns the production url' do
      end
    end

    context 'receiving other value than "production"' do
      xit 'returns the sandbox url' do
      end
    end
  end
end

RSpec.describe Volabit::Client do
  subject { described_class }
  # Lots of tests required.
end
