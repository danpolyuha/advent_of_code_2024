#############################################################################
# 1
#############################################################################

connections = File.readlines('input23.txt').map { |line| [line[0..1], line[3..4]] }

connection_map = Hash.new { |h, k| h[k] = Set.new }
connections.each do |c1, c2|
  connection_map[c1] << c2
  connection_map[c2] << c1
end

parties = []
connections.each do |comp1, comp2|
  found = false
  parties.each do |party|
    party_ok = party.all? do |item|
      (item == comp1 || connection_map[item].include?(comp1)) && (item == comp2 || connection_map[item].include?(comp2))
    end

    if party_ok
      party << comp1 << comp2
      found = true
    end
  end

  parties << Set.new([comp1, comp2]) unless found
end

sets_by_3 = Set.new
parties.each do |party|
  party.to_a.combination(3).each do |c|
    sets_by_3 << Set.new(c) if c.any? { |comp| comp.start_with?('t') }
  end
end

puts sets_by_3.count

#############################################################################
# 2
#############################################################################

connections = File.readlines('input23.txt').map { |line| [line[0..1], line[3..4]] }

connection_map = Hash.new { |h, k| h[k] = Set.new }
connections.each do |c1, c2|
  connection_map[c1] << c2
  connection_map[c2] << c1
end

parties = []
connections.each do |comp1, comp2|
  found = false
  parties.each do |party|
    party_ok = party.all? do |item|
      (item == comp1 || connection_map[item].include?(comp1)) && (item == comp2 || connection_map[item].include?(comp2))
    end

    if party_ok
      party << comp1 << comp2
      found = true
    end
  end

  parties << Set.new([comp1, comp2]) unless found
end

puts parties.max_by(&:count).to_a.sort.join(',')
