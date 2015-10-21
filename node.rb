class Node

	attr_accessor :parent, :children, :value, :root, :leaf

	def initialize (value)
		@value = value
		@children = []
		@leaf = false
		@root = false

	end

end

def build_tree(values, parent = nil)
#I suspect this part is going to be recursive

	#base case
	if values.empty?
		return
	elsif values.length == 1
		current_node = Node.new(values[0])
		current_node.parent = parent
		current_node.parent.children.push(current_node)
		current_node.leaf = true
		child_values = "leaf"
	else
		current_index = (values.length / 2) 
		current_node = Node.new(values[current_index])
		current_node.parent = parent
		if parent
			current_node.parent.children.push(current_node)
		end
		build_tree(values[0..(current_index - 1)], current_node)
		build_tree(values[(current_index + 1)..-1], current_node)
		child_values = []
		current_node.children.each {|c| child_values.push c.value}
	end
	if current_node.parent 
		parent_value = current_node.parent.value 
	else
		parent_value = "root"
		current_node.root = true
	end
	print "Value #{current_node.value}, parent #{parent_value}, children #{child_values}\r\n"


#check on how attribute accessors work, for how to pass in a parent

end

build_tree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])