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
		new_node_parent = where_do_i_belong(current_node.value, @ultimate_root)
		#once you find where it belongs 
		#hook it up to the parent node
		if new_node_parent
			current_node.parent = new_node_parent
			current_node.parent.children.push(current_node)
		end

		if values.length > 1
			first_half = (values[0..(current_index - 1)])
			second_half = (values[(current_index + 1)..-1])
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

		#I think this is where the problem is.  sometimes both nodes are bigger than the root
		if parent == nil
			@ultimate_root = Node.new(value)
			return nil
		else
			if value <= parent.value
				chosen_child = parent.children.select {|child| child.value <= parent.value}
			else
				chosen_child = parent.children.select {|child| child.value > parent.value}
			end
			if chosen_child.empty?
				return parent
			elsif chosen_child.length == 1 && ((value <= parent.value && chosen_child[0].value > parent.value) ||
					(value > parent.value && chosen_child[0].value <= parent.value))
					return parent
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

=begin
	
	#this is from the basic binary start in middle
def build_tree(values, parent = nil)
#I suspect this part is going to be recursive

	#no possible children (base case)
	if values.length == 1
		current_node = Node.new(values[0])
		current_node.parent = parent
		current_node.parent.children.push(current_node)
		current_node.leaf = true
		child_values = "leaf"
	#possible children	
	else
		current_index = (values.length / 2) 
		current_node = Node.new(values[current_index])
		current_node.parent = parent
		if parent
			current_node.parent.children.push(current_node)
		else 
			current_node.root = true
			parent_value = "root"
		end
		build_tree(values[0..(current_index - 1)], current_node)
		build_tree(values[(current_index + 1)..-1], current_node)
		child_values = []
		current_node.children.each {|c| child_values.push c.value}
	end
	#finding value for printed statement. nothing shows up if I put it in the if earlier
	if current_node.parent 
		parent_value = current_node.parent.value 
	end
	print "Value #{current_node.value}, parent #{parent_value}, children #{child_values}\r\n"


end
=end