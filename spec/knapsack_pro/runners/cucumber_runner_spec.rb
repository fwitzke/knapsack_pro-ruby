describe KnapsackPro::Runners::CucumberRunner do
  subject { described_class.new(KnapsackPro::Adapters::CucumberAdapter) }

  it { should be_kind_of KnapsackPro::Runners::BaseRunner }

  describe '.run' do
    let(:args) { '--custom-arg' }

    after { described_class.run(args) }

    it do
      stringify_test_file_paths = 'features/a.feature features/b.feature'
      runner = instance_double(described_class,
                               stringify_test_file_paths: stringify_test_file_paths)
      expect(described_class).to receive(:new)
      .with(KnapsackPro::Adapters::CucumberAdapter).and_return(runner)

      expect(Kernel).to receive(:exit)
      expect(Kernel).to receive(:system).with('bundle exec cucumber --custom-arg -- features/a.feature features/b.feature')
    end
  end
end