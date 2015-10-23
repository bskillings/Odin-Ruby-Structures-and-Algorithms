class Node

	attr_accessor :parent, :children, :value, :root

	def initialize (value)
		@value = value
		@children = []
		@root = false
		@parent = nil
	end

end

class Tree

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
			current_node.parent.children.push(current_node)
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
				chosen_child = parent.children.select {|child| child.value <= parent.value}
			else
				chosen_child = parent.children.select {|child| child.value > parent.value}
			end

			#return parent if no children
			if chosen_child.empty?
				return parent

			#return parent if nothing on appropriate side
			elsif chosen_child.length == 1 && ((value <= parent.value && chosen_child[0].value > parent.value) ||
					(value > parent.value && chosen_child[0].value <= parent.value))
					return parent
			
			#keep going down appropriate side
			else
				further_child = where_do_i_belong(value, chosen_child[0])
				return further_child
			end
			return 
		end
	end

end



tree = Tree.new([8, 1, 5, 4, 6, 12, 7, 9, 2, 10, 14, 11, 3, 13])
tree2 = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
tree3 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

