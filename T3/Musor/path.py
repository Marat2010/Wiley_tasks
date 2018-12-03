import json
import os

# path = '/home/marat/MPyt/Wiley_tasks/'
fileName = 'friend.json'
# self.fullPath = os.path.join(path, fileName)
_USERNAME = os.getenv("SUDO_USER") or os.getenv("USER")
_HOME = os.path.expanduser('~'+_USERNAME)
print(_USERNAME)
print(_HOME)

home = '~'
path = os.path.join(home, 'MPyt/Wiley_tasks/', fileName)
print(path)