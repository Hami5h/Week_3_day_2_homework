require('pry')
require_relative('models/bounty.rb')


bounty_1 = Bounty.new(
  {
    'name' => 'Helen',
    'species' => 'Rat',
    'bounty_value' => '769',
    'homeworld' => 'Saturn'
  }
)

bounty_2 = Bounty.new(
  {
    'name' => 'Brian',
    'species' => 'Bird',
    'bounty_value' => '450',
    'homeworld' => 'Jupiter'
  }
)

binding.pry
nil
