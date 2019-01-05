RSpec.describe Faker::Csv::Maker do
  describe 'Instance Method' do
    context '#make' do
      context 'normal' do
        subject { described_class.new({cat: 'dog'}).make }
        it do
          is_expected.to eq("cat\ndog\n")
        end
      end

      context 'multiple patterns' do
        subject { described_class.new({cat: ['dog', 'pig']}).make }
        it do
          is_expected.to eq("cat\ndog\npig\n")
        end
      end

      context 'call ruby method' do
        subject { described_class.new({cat: 'rb 1 + 1'}).make }
        it do
          is_expected.to eq("cat\n2\n")
        end
      end
    end
  end
end
