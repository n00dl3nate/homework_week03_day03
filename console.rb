require_relative('./models/bounty_hunter.rb')
require('pry')

# BountyHunter.delete_all

bounty1 = BountyHunter.new(
  {  'name' => "Wally",
     'species' => "Wolf",
     'bounty_value' => 4000,
     'danger_level' => "Medium"}
)

bounty2 = BountyHunter.new(
  {  'name' => "Django",
     'species' => "giraffe",
     'bounty_value' => 2000,
     'danger_level' => "Low"}
)

bounty3 = BountyHunter.new(
{    'name' => "Buster",
     'species' => "Bear",
     'bounty_value' => 20000,
     'danger_level' => "High"}
)

bounty1.save()

bounty2.save

bounty3.save

bounty1.bounty_value = 40000
bounty1.update()

p BountyHunter.find(29)
BountyHunter.find_delete(35)
