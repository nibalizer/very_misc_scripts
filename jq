# jq quick hacks


# pretty print
cat foo.json | jq '.'

# grab a specific item
cat foo.json | jq '.kitchen.sink'

# grab an item out of a list

cat foo.json | jq '.kitchens[4].sink'

# grab all the items out of a list of objects

cat foo.json | jq '.kitchens[].sink'

# delete an item

cat foo.json | jq -c 'del(.kitchens[].sink'
