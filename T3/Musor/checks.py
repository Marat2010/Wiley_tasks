import json
import os

cur_path = os.getcwd()
fileName = 'friend.json'
file_path = os.path.join(cur_path, fileName)
json_obj = json.load(open(file_path))
tags = 'tags'
user = 'laborum'
num_id = 2

# for elem in json_obj:
#     if user in elem['tags']:
#         for fr_elem in elem['friends']:
#             if fr_elem.get('id') == num_id:
#                 print('%s\'s friends: %s ' % (user, fr_elem['name']) )

# def recursive(_item):
#     if _item.__class__ == {}.__class__:
#         if user in _item['tags']:
#             print('qqqqqq',_item['tags'])
#
#         for i in _item:
#             #print(_item[i])
#             recursive(_item[i])
#         print('-----------')
#     if _item.__class__ == [].__class__:
#         for i in _item:
#             print(i)
#             recursive(i)

def recursive(obj):
    if isinstance(obj, dict):
        for key, value in obj.iteritems():
            print(key)
            recursive(value)
    elif isinstance(obj, list):
        for item in obj:
            recursive(item)
    else:
        print(obj)

recursive(json_obj)
