reports = File.readlines('input02.txt').map { |line| line.split.map(&:to_i) }

########################################################################################################################
# 1
########################################################################################################################

safe_report_count = reports.count do |report|
  diffs = report.each_cons(2).map { |level1, level2| level2 - level1 }
  diffs.all? { |diff| (-3..-1).include?(diff) } || diffs.all? { |diff| (1..3).include?(diff) }
end

puts safe_report_count
# 624

########################################################################################################################
# 2
########################################################################################################################

def safe_report?(report)
  diffs = report.each_cons(2).map { |level1, level2| level2 - level1 }
  diffs.all? { |diff| (-3..-1).include?(diff) } || diffs.all? { |diff| (1..3).include?(diff) }
end

safe_report_count = reports.count do |report|
  safe_report?(report) || report.each_index.any? do |index_to_remove|
    safe_report?(report[0, index_to_remove] + report[index_to_remove + 1..])
  end
end

puts safe_report_count
# 658
