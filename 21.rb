#############################################################################
# 1
#############################################################################

numeric = {
  'A' => {
    '0' => 2, '3' => 2,
    '2' => 3, '6' => 3,
    '1' => 4, '5' => 4, '9' => 4,
    '4' => 5, '8' => 5,
    '7' => 6
  },
  '0' => {
    'A' => 2, '2' => 2,
    '1' => 3, '3' => 3, '5' => 3,
    '4' => 4, '6' => 4, '8' => 4,
    '7' => 5, '9' => 5
  },
  '1' => {
    '2' => 2, '4' => 2,
    '0' => 3, '3' => 3, '5' => 3, '7' => 3,
    'A' => 4, '6' => 4, '8' => 4,
    '9' => 5
  },
  '2' => {

  }
}

directional = {}

codes = File.readlines('input_test03.txt').map(&:chomp).map(&:chars)

result = 0



#############################################################################
# 2
#############################################################################

