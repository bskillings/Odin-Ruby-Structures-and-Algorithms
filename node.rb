class Node

	attr_accessor :parent, :children, :value, :root

	def initialize (value)
		@value = value
		@children = Array.new(2)
		@root = false
		@parent = nil
	end

end

class Tree

	attr_accessor :ultimate_root

	def initialize(values)
		@values = values
		@first = true
		@ultimate_root = nil
		puts "New tree"
		build_tree(@values)

	end

	def build_tree(values)
	#I suspect this part is going to be recursive
	#create a node

		current_index = (values.length / 2) 
		current_node = Node.new(values[current_index])

		#find where it belongs (its parent)
		new_node_parent = where_do_i_belong(current_node.value, @ultimate_root)
	
		#hook it up to its parent
		if new_node_parent
			current_node.parent = new_node_parent
			if current_node.value <= current_node.parent.value
				current_node.parent.children[0] = current_node
			else
				current_node.parent.children[1] = current_node
			end
		end

		#if there is more in the array, break it in half
		if values.length > 1
			first_half = (values[0..(current_index - 1)])
			second_half = (values[(current_index + 1)..-1])

			#if there is anything in each half, build a tree from that
			if first_half.length > 0
				build_tree(first_half)
			end
			if second_half.length > 0
				build_tree(second_half)
			end
		end
	
		#creating the output text
		parent_value = current_node.parent ? current_node.parent.value : "none"
		print "value #{current_node.value}, parent #{parent_value}\r\n"
	
	end

	def where_do_i_belong(value, parent)

		#return no parent if ultimate root
		if parent == nil
			@ultimate_root = Node.new(value)
			return nil

		else

			#choose which side to go down based on value
			if value <= parent.value
				chosen_child = parent.children[0]
			else
				chosen_child = parent.children[1]
			end

			#return parent if no children
			if chosen_child == nil
				return parent

			#return parent if nothing on appropriate side
			elsif ((value <= parent.value && chosen_child.value > parent.value) ||
					(value > parent.value && chosen_child.value <= parent.value))
					return parent
			
			#keep going down appropriate side
			else
				further_child = where_do_i_belong(value, chosen_child)
				return further_child
			end
			return 
		end
	end

	#built and print ouput string
	def target_found_message(target_value, description, node)
		print "#{target_value} found! Here is the #{description} path: \r\n"
		building_path = []
		building_path.unshift(node.value)
		while node.parent != nil
			node = node.parent
			building_path.unshift(node.value)
		end
		print "#{building_path}\r\n"
	end

	def breadth_first_search(target_value)
		searching_queue = [@ultimate_root]
		while target_value != searching_queue[0].value
			puts "comparing #{target_value} to #{searching_queue[0].value}..."
			going_to_children = searching_queue.shift
			going_to_children.children.each do |child| 
				if child != nil
					searching_queue.push(child)
				end
			end
		end
		target_found_message(target_value, "breadth-first", searching_queue[0])
	end

	def depth_first_search(target_value)
		searching_stack = [@ultimate_root]
		while target_value != searching_stack.last.value
			puts "comparing #{target_value} to #{searching_stack.last.value}..."
			test_me = searching_stack.pop
			if test_me.children
				test_me.children.reverse.each do |child| 
					if child != nil
						searching_stack.push(child)
					end
				end
			end
		end

		target_found_message(target_value, "depth-first", searching_stack.last)
	end

	def dfs_rec(target_value, node_to_compare)

		#the secret here is to return true and false
		#if node == nil return false
		if node_to_compare == nil
			return false
		end
		
		puts "comparing #{target_value} to #{node_to_compare.value}"

		#if node == target_value return true
		if node_to_compare.value == target_value
			target_found_message(target_value, "recursive", node_to_compare)
			return true
		end

		#if dfs_rec on left node is true return true
		if (dfs_rec(target_value, node_to_compare.children[0]))
			return true
		end

		#if dfs_rec on right is true return true
		if (dfs_rec(target_value, node_to_compare.children[1]))
			return true
		end

		#if you get down this far nothing else matters
		return false
		
	end
	
end

#Never do this.  Use a binary search on a binary tree.

tree = Tree.new([8, 1, 5, 4, 6, 12, 7, 9, 2, 10, 14, 11, 3, 13])
tree.breadth_first_search(5)
tree.depth_first_search(5)
tree.dfs_rec(5, tree.ultimate_root)

tree2 = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
tree2.breadth_first_search(5)
tree2.depth_first_search(5)
tree2.dfs_rec(5, tree2.ultimate_root)

tree3 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree3.breadth_first_search(5)
tree3.depth_first_search(5)
tree3.dfs_rec(5, tree3.ultimate_root)

