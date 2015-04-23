class Move_tree
	attr_accessor :square, :parent, :children_arr
end

def knight_moves(start, target)
	path = []
	possible_solutions = $nodes.select { |node| node.square == target }
	#puts $nodes
	solutions = possible_solutions.select { |e| calc_level(e) <= $min}

	puts "No. of solutions = #{solutions.length}"
	puts "min = #{$min}"
	puts ""

	node = solutions[rand(solutions.length)]
	path = [node.square]
	nd = node
	while nd.parent
		path << nd.parent.square
		nd = nd.parent
	end

	puts "The path is: "
	path.pop
	path.reverse!
	path.length.times do |i|
		puts "N#{path[i][0]}#{path[i][1]}"
	end

end

def all_possible_moves(start)
	start[0] = start[0].ord
	end_arr = []
	for i in -2..2
		next if i == 0
		x = start[0] + i
		next unless x >= 97 and x <= 104
		y = start[1] + (3-i.abs)
		
		if y >= 1 and y <=8
			move = [x.chr, y]
				end_arr << move
		end

		y = start[1] - (3-i.abs)

		
		if y >= 1 and y <=8
			move = [x.chr, y] 
				end_arr << move
		end
	end
	start[0] = start[0].chr
	return end_arr
end

#$nodes = []
#$min = 6
def build_tree(start,target, parent = nil)
	node = Move_tree.new
	node.parent = parent
	node.square = start
	$nodes << node
	parent.children_arr = parent.children_arr.to_a + [node] if parent
	
	parent_arr = [node]
	nd = node
	while nd.parent
		parent_arr << nd.parent
		nd = nd.parent
	end
	$min = parent_arr.length-1 if node.square == target and parent_arr.length < $min

	return nil if node.square == target
	possible_moves = all_possible_moves(start)

	possible_moves.each do |move|
		build_tree(move,target, node) if parent_arr.length <=$min and parent_arr.all? { |e| e.square != move }
	end
	return nil
end

def calc_level(node)
	parent_arr = []
	nd = node
	while nd.parent
		parent_arr << nd.parent
		nd = nd.parent
	end
	return parent_arr.length
end

=begin
puts "Enter Knight's Starting square and Target square."
p "Start: "
start = gets.chomp
start = start.split("")
start[1] = start[1].to_i
p "Target: "
target = gets.chomp
target = target.split("")
target[1] = target[1].to_i
build_tree(start,target)
knight_moves(start, target)
=end

def script
	#start = [rand(97..104).chr,rand(1..8)]
	#target = [rand(97..104).chr,rand(1..8)]
	start = ["b",8]
	target = ["a",8]
	while target == start
		target = [rand(97..104).chr,rand(1..8)]
	end
	puts ""
	puts "Start: #{start[0]}#{start[1]}"
	puts "Target: #{target[0]}#{target[1]}"
	puts ""
	build_tree(start,target)
	knight_moves(start, target)
end

1.times do
	$nodes = []
	$min = 6
	script
end