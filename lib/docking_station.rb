require_relative 'bike'

class DockingStation

	attr_reader :capacity
	DEFAULT_CAPACITY = 20

	def initialize (capacity = DEFAULT_CAPACITY)
		@capacity = capacity
		@bikes = []
	end

	def release_bike
		if empty?
			fail  "No bikes to release"
		elsif @bikes[(@bikes.size-1)].working? == false
			fail "The bike is broken"
		else
			@bikes.pop
		end
	end

	def dock(bike)
		if full?
			fail "Already at capacity"
		else
			@bikes << bike
		end
	end

	def select_broken_bikes(van_capacity)
		@bikes.reject {|bike| bike.working?}.first(van_capacity)
	end

private

	attr_reader :bikes

	def empty?
		@bikes.length == 0
	end

	def full?
		@bikes.length == @capacity
	end
end