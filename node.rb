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
		@ultimate_root = Node.new(values.shift)
		puts "creating root, value #{@ultimate_root.value}"
		build_tree

	end

	def build_tree
	#I suspect this part is going to be recursive
	#okay let's try this 

		#for each value
		@values.each do |current_value|

		#create a node
			current_node = Node.new(current_value)
		#check if it's the first
		#this part might be recursive
			new_node_parent = where_do_i_belong(current_value, @ultimate_root)
			#once you find where it belongs 
			#hook it up to the parent node
			current_node.parent = new_node_parent
			current_node.parent.children.push(current_node)

			#creating the output text
			parent_value = current_node.parent ? current_node.parent.value : "none"
			print "value #{current_value}, parent #{parent_value}\r\n"
		end

	end

	def where_do_i_belong(value, parent)

		#I think this is where the problem is.  sometimes both nodes are bigger than the root
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



tree = Tree.new([8, 1, 5, 4, 6, 12, 7, 9, 2, 10, 14, 11, 3, 13])
tree2 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])