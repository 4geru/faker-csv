RSpec.describe Faker::Csv::Maker do
  describe 'Instance Method' do
    context '#make' do
      context 'array patterns' do
        subject { described_class.new({cat: ['dog', 'pig']}).make }
        it do
          is_expected.to eq("cat\ndog\npig\n")
        end
      end

      context 'index' do
        subject { described_class.new({cat: 'index'}).make }
        it do
          is_expected.to eq("cat\n1\n")
        end
      end

      context 'call ruby method' do
        subject { described_class.new({cat: 'Faker::Name.name'}).make }
        it do
          is_expected.to match(/cat\n.*\n/)
        end
      end

      context 'faker method' do
        subject { described_class.new({cat: 'rb 1 + 1'}).make }
        it do
          is_expected.to eq("cat\n2\n")
        end
      end

      context 'normal' do
        subject { described_class.new({cat: 'dog'}).make }
        it do
          is_expected.to eq("cat\ndog\n")
        end
      end
    end
  end
end
