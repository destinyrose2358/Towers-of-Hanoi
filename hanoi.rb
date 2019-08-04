require_relative "player"
require_relative "tower"
#require 'curses'

class Hanoi
    attr_reader :moves, :taken
    

    def initialize(size = 3)
        @towers = [Tower.filled_tower(size), Tower.new(size), Tower.new(size)]
        @player = Player.new
        @moves = 0
        @size = size
        #Curses.init_screen
        #Curses.curs_set 0
        #@previous_frame = Array.new(size) { Array.new(size) }
        @graphics = Hash.new { |hash, key| hash[key] = self.create_disk(key)}
    end

    def win?
        !@towers[0].filled? && (@towers[1].filled? || @towers[2].filled?)
    end

    def move
        system "clear"
        self.generate_screen
        puts "You have made #{@moves} moves"
        tower_from, tower_to = @player.get_move
        if tower_from != nil && tower_to != nil
            @towers[tower_from].move_to(@towers[tower_to])
            @moves += 1
        elsif tower_from == -1
            #reset the towers, and moves to their start, then start solving
            @towers = [Tower.filled_tower(@size), Tower.new(@size), Tower.new(@size)]
            @moves = 0
            self.solve
        end
    end

    def solve

        until self.win?
            #update the graphics and stop
            puts "\e[H\e[2J"
            self.generate_screen
            puts "You have made #{@moves} moves"

            #calculate disk to move
            disk = 1
            until ((@moves + 1) - (2 ** (disk - 1))) % (2 ** disk) == 0
                disk += 1
            end

            #find disk in towers
            tower_from = @towers.index do |tower|
                tower.disks.include?(disk)
            end

            #calculate the tower to move to
            tower_to = (tower_from + (2 ** (disk - 1))) % 3

            #move the disk
            @towers[tower_from].move_to(@towers[tower_to])

            @moves += 1
            sleep([[30 / ((2 ** @size) - 1), 0.25].min, 0.05].max)
        end
    end

    def create_disk(length)
        graphic = ""

        if length != nil
            disk_s = length * 2 - 1
        else
            disk_s = 0
        end

        max = @size * 2 - 1

        ((max - disk_s) / 2).times { graphic += "⬜️ " }

        if disk_s == 0
            graphic += "🔸 "
        else
            disk_s.times { graphic += "⬛️ "}
        end

        ((max - disk_s) / 2).times { graphic += "⬜️ " }

        graphic
    end

    def generate_screen
        screen = @towers.map(&:disks)

        (0...@size).reverse_each do |col|
            print "⬜️ "
            (0...3).each do |row|
                print @graphics[screen[row][col]]
                print "⬜️ "
            end
            print "\n"
        end
        #sleep([30 / ((2 ** @size) - 1).to_f, 0.25].min)
    end

    # def update_screen
    #     screen = @towers.map(&:disks)

    #     #create a scheme mapping changes
    #     scheme = screen.map.with_index do |piece, idx|
    #         if @previous_frame[idx] != piece
    #             piece
    #         else
    #             nil
    #         end
    #     end

    #     @previous_frame = screen

    #     (0...@size).reverse_each do |col|
    #         print "⬜️ "
    #         (0...3).each do |row|
    #             if scheme[row][col]
    #                 Curses.setpos(row, 1 + 3 * (@size * 2 - 1))
    #                 Curses.addstr(@graphics[screen[row][col]])
    #             end
    #             #print @graphics[screen[row][col]]
    #             #print "⬜️ "
    #         end
    #         #print "\n"
    #     end


    # end

end