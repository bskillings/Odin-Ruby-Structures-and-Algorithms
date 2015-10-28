#A couple of thoughts before I begin

#how do I create a tree?  Do I create it on the fly? because it could be an infiniate depth

#I could make the children by having an x and y coordinate and a system like
#child 1 = x+1, Y+2
#child 2 = x+1, y-2
#child 3 = x-1, y+2
# and so on 
# and then check if either value is below 1 or above 8 and throw it out
#but then when do I stop?

#I could check to see if a location is already in the parent chain, but that
# => seems inefficient

#on the other hand, I think it wants me to use breadth first search to prevent
# => going around in loops, so theoretically the loops exist

#shall I do breadth first and spawn children on the fly?
#well, it wasn't anywhere on this row, back to the left 
# => and what are the children of that?

class GameBoard
	#is this where I make the move tree? 
	#the only thing I can think of here is to see if moves are legal
	#but that's easy enough to check

end

class Knight

	def initialize(x, y)
		@current_x = x
		@current_y = y
	end

end

class MoveTree
	def initialize(x, y)

	end
end

class MoveNode
	def initialize(x, y)
		x_value = x
		y_value = y
		children = []
	end
end