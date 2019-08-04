class Player


    def get_move
        puts "Which tower would you like to move from and to? ex '1 2'"
        gets.chomp.split(" ").map { |num| num.to_i - 1 }
    end


end