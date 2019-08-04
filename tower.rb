class Tower
    attr_reader :disks

    def initialize(size = 3)
        @disks = []
        @size = size
    end

    def move_to(tower)
        if !tower.min
            tower << @disks.pop
            return true
        end

        if tower.min > self.min
            tower << @disks.pop
            return true
        end

        false
    end

    def <<(disk)
        @disks << disk
    end

    def min
        @disks[-1]
    end

    def self.filled_tower(num = 3)
        tower = Tower.new
        (1..num).reverse_each { |disk| tower << disk }
        tower
    end

    def filled?
        @disks.length == @size
    end
end