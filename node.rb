class Node

	attr_accessor :parent, :children, :value, :root, :leaf, :ultimate_root

	def initialize (value)
		@value = value
		@children = []
		@leaf = false
		@root = false
		@parent = nil
	end

end

class Tree

	def initialize(values)
		@values = values
		@first = true
		@ultimate_root = Node.new(values.shift)
		puts "creating first node, value #{@ultimate_root.value}"
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
			put_node_here = where_do_i_belong(current_value, @ultimate_root)
			#once you find where it belongs 
			#hook it up to the parent node
			current_node.parent = put_node_here
			current_node.parent.children.push(current_node)

			#creating the output text
			parent_value = current_node.parent ? current_node.parent.value : "none"
			root_value = current_node.parent ? @ultimate_root.value : "none"
			print "value #{current_value}, parent #{parent_value}, root #{root_value}\r\n"
		end

	end

	def where_do_i_belong(value, parent)

	if parent.children.length < 2
			return parent
		else
			if value <= parent.value
				chosen_child = parent.children.select {|child| child.value <= parent.value}
			else
				chosen_child = parent.children.select {|child| child.value > parent.value}
			end
			if chosen_child[0].children
				where_do_i_belong(value, chosen_child[0])
			else
				return chosen_child[0]
			end
			return 
		end
	end

end

#error message end of day oct 21

=begin
	
	node.rb:41:in 'block in build_tree': undefined method 'children' for nil:NilClass (NoMethodError)
	from node.rb:31:in 'each'
	from node.rb:31:in 'build_tree'
	from node.rb:22:in 'initialize'
	from node.rb:114:in 'new'
	from node.rb:114:in '<main>'
=end




tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])