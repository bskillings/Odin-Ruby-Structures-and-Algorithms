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

	def initialize(current_coordinates, goal_coordinates)
		@current_coordinates = current_coordinates
		tree = MoveTree.new(current_coordinates[0], current_coordinates[1])
		tree.search_for_move(goal_coordinates)
	end

end

class MoveTree
	def initialize(x, y)
		@root = MoveNode.new(x, y)
		create_acceptable_children(@root)
	end

	def create_acceptable_children(current_node)
		potential_children = []
		x = current_node.location[0]
		y = current_node.location[1]
		#find all the theoretically possible moves
		potential_children.push([x+1, y+2])
		potential_children.push([x+1, y-2])
		potential_children.push([x-1, y+2])
		potential_children.push([x-1, y-2])
		potential_children.push([x+2, y+1])
		potential_children.push([x+2, y-1])
		potential_children.push([x-2, y+1])
		potential_children.push([x-2, y-1])

		#go down the list of potential children
		potential_children.each do |child|

			child_is_acceptable = true
			
			#reject if off the board
			if child[0] < 1 || child[0] > 8 or child[1] < 1 or child[1] > 8
				child_is_acceptable = false
			end

			#reject if identical values in parent chain
			unless current_node.parent_value_chain.empty?
				current_node.parent_value_chain.each do |parent_coordinates|
					if parent_coordinates[0] == child[0] || parent_coordinates[1] == child[1]
						child_is_acceptable = false
					end
				end
			end
					
			#create the new node
			if child_is_acceptable == true
				new_child = MoveNode.new(child[0], child[1])
				new_child.parent = current_node
				new_child.parent_value_chain = create_value_chain(current_node).reverse
				puts "creating new child at #{child[0]}, #{child[1]}, parent chain is #{new_child.parent_value_chain}"
				current_node.children.push(new_child)
			end
		end
		
		#recursively create grandchildren &c
		if current_node.children.empty?
			return
		else
			current_node.children.each do |child_node|
			create_acceptable_children(child_node)
			end
		end

	end

	def create_value_chain(current_parent)
		value_chain = []
		value_chain.push(current_parent.location)
		while current_parent.parent
			current_parent = current_parent.parent
			value_chain.push(current_parent.location)
		end
		return value_chain
	end



	#do a breadth-first search for the goal square
	#this also isn't working oct 29, 1:00
	def search_for_move(goal_coordinates)
		searching_queue = [@root]
		while goal_coordinates[0] != searching_queue[0].location[0] || goal_coordinates[1] != searching_queue[0].location[0]
			puts "comparing #{goal_coordinates} to #{searching_queue[0].location}..."
			going_to_children = searching_queue.shift
			going_to_children.children.each do |child| 
				if child != nil
					searching_queue.push(child)
				end
			end
		end
		puts "#{goal_coordinates} found! Here is the path:"
		print searching_queue[0].parent_chain
	end
end

class MoveNode

	attr_accessor :location, :children, :parent, :parent_value_chain
	def initialize(x, y)
		@location = [x, y]
		@children = []
		@parent = nil
		@parent_value_chain = []
	end
end

knight = Knight.new([4, 4], [5, 6])

#two issues right now (oct 30 10:00):

#if I set it to find something in the first row, it doesn't

#also, I'm getting a nil class error if there are no children, rather than just returning.
#I think this is when the queue is empty or when something nil gets to the front, not sure which