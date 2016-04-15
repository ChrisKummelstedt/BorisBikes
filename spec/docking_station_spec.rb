require 'docking_station'
require 'bike'

describe DockingStation do

  let(:bike) { double :bike, working?: true }
  let(:broken_bike) { double :broken_bike, working?: false}
  let(:van) {double :van, capacity: 2}

  it { is_expected.to respond_to :release_bike }

  context "#release_bike" do

    it "releases a new bike" do
      #bike = double(:bike)                        #reminder that this line is above too :)
      #allow(bike).to receive(:working?) {true}    #reminder that this line is above too :)
      subject.dock(bike)
      expect(subject.release_bike).to be_working
    end

    it "raises error when there are no bikes left and there is a request to release bike" do
      expect {bike = subject.release_bike}.to raise_error("No bikes to release")
    end
  end

  context "#dock" do

    it "raises error when the bike rack is at overcapacity" do
      bike = :bike
      expect {(subject.capacity+1).times {subject.dock(bike)}}.to raise_error("Already at capacity")
    end

    it 'allows public to dock bikes' do
      expect(subject).to respond_to(:dock).with(1).argument
    end
  end

  context "#initialize" do

    it "initializes with a DEFAULT_CAPACITY of 20" do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end

    it "allows a default value to be set when creating a new bike" do
      dock = DockingStation.new 25
      expect(dock.capacity).to eq 25
    end
  end

  context "Van interaction" do

    it "selects 1 broken bike" do
      subject.dock(bike)
      subject.dock(broken_bike)
      expect(subject.select_broken_bikes(van.capacity)).to include broken_bike
    end

    it "does not include working bikes" do
      subject.dock(bike)
      subject.dock(broken_bike)
      expect(subject.select_broken_bikes(van.capacity)).to_not include bike
    end

    it "with van capacity 2 it only selects 2 broken bikes" do
      3.times do
        subject.dock(broken_bike)
      end
      expect(subject.select_broken_bikes(xx).size).to eq 2
    end

    xit "removes broken bikes that are added to the van" do
    end

  end

end