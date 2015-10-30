class Knight

	def initialize(current_coordinates, goal_coordinates)
		@current_coordinates = current_coordinates
		puts "New knight at #{@current_coordinates}, looking for #{goal_coordinates}"
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
#				puts "creating new child at #{child[0]}, #{child[1]}, parent chain is #{new_child.parent_value_chain}"
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
	def search_for_move(goal_coordinates)
		searching_queue = [@root]
		goal_x = goal_coordinates[0]
		goal_y = goal_coordinates[1]
		found = false
		testing_node = @root

		while found == false
			testing_node = searching_queue.shift
			testing_x = testing_node.location[0]
			testing_y = testing_node.location[1]

#			puts "testing x: #{goal_x} to #{testing_x}, testing y; #{goal_y} to #{testing_y}"

			if (goal_x == testing_x) && (goal_y == testing_y)
				found = true
			else
				testing_node.children.each do |test_child|
					searching_queue.push(test_child)
				end
			end
		end

		puts "#{goal_coordinates} found! Here are the waypoints:"
		print testing_node.parent_value_chain
		print ", arrive at #{testing_node.location}\r\n"
		puts ""
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

knight = Knight.new([1, 1], [2, 3])
knight2 = Knight.new([1, 1], [4, 4])
knight3 = Knight.new([4, 4], [1, 1])

