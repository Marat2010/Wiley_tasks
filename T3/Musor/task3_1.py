import json
import os

#_USERNAME = os.getenv("SUDO_USER") or os.getenv("USER")
#_HOME = os.path.expanduser('~'+_USERNAME)

cur_path = os.getcwd()
fileName = 'friend1.json'
file_path = os.path.join(cur_path, fileName)
y = json.load(open(file_path))

user = input('Enter name (Default: laborum):')
num_id = input('Enter number id (Default: 2): ')

if not user:
    user = 'laborum'
if not num_id:
    num_id = 2
else:
    num_id = int(num_id)

# for elem in y:
#     print()
#     print(elem['tags'])

for elem in y:
    print()
    if user in elem['tags']:
        print('______________')
        for fr_elem in elem['friends']:
            print(fr_elem)
            if fr_elem.get('id') == num_id:
                print('%s\'s friends: %s ' % (user, fr_elem['name']) )
