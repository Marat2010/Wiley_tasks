import json
import os

# path = '/home/marat/MPyt/Wiley_tasks/'
# fileName = 'friend.json'

p = '/home/marat/MPyt/Wiley_tasks/friend1.json'

user = 'laborum'
num_id = 2
# user = input('Enter name:')
# num_id = input('Enter number id: ')

print(user)
print(num_id)

y = json.load(open(p))


# for elem in y:
#     print()
#     print(elem['tags'])

# .items():
#    print("Key: " + k)
#    print("Value: " + str(v))

for elem in y:
    print()
    if user in elem['tags']:
        print(elem['tags'])
        print(elem['friends'])
        print('______________')
        for fr_elem in elem['friends']:
            print(fr_elem)
            if fr_elem.get('id') == num_id:
                print('%s\'s friends: %s ' % (user, fr_elem['name']) )
