require 'docking_station.rb'
require 'bike.rb'

describe DockingStation do

  context "#release_bike" do

    it { is_expected.to respond_to :release_bike }

    it "releases a new bike" do
      bike = Bike.new
      subject.dock(bike)
      expect(bike).to be_working
    end


    it "raises error when there are no bikes left and there is a request to release bike" do
      expect {bike = subject.release_bike}.to raise_error("No bikes to release")
    end
  end

  context "#dock" do

    it "raises error when the bike rack is at overcapacity" do
      bike = Bike.new
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
end
