#needs to have three towers, that can have a piece added only if the previous
#top piece is bigger than the piece being moved. can only remove the top piece
#need to be able to ask the player for input.
#ex '0 1' would move the top piece of tower 0 to tower 1.
#

require_relative "hanoi"

print "How many disks would you like? "
hanoi = Hanoi.new(gets.chomp.to_i)

until hanoi.win?
    hanoi.move
end

system "clear"
hanoi.generate_screen
puts "Hooray, you won in #{hanoi.moves} moves!"