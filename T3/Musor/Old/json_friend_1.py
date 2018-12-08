import json
import os

# Run: "python3 json_friend.py"

#_USERNAME = os.getenv("SUDO_USER") or os.getenv("USER")
#_HOME = os.path.expanduser('~'+_USERNAME)

cur_path = os.getcwd()

fileName = input('Enter File name (Default: friend.json):')
if not fileName:
    fileName = 'friend.json'
file_path = os.path.join(cur_path, fileName)
js_obj = json.load(open(file_path))

user = input('Enter name (Default: laborum):')
num_id = input('Enter number id (Default: 2): ')
if not user:
    user = 'laborum'
if not num_id:
    num_id = 2
else:
    num_id = int(num_id)

for elem in js_obj:
    if user in elem['tags']:
        for fr_elem in elem['friends']:
            if fr_elem.get('id') == num_id:
                print('%s\'s friends: %s ' % (user, fr_elem['name']) )

