import json
import os

cur_path = os.getcwd()
fileName = 'friend3.json'
file_path = os.path.join(cur_path, fileName)
json_obj = json.load(open(file_path))
tags = 'tags'
friends = 'friends'
user = 'laborum'
#user = 'exploit'
num_id = 2


def find(elem):
    for fr_elem in elem.get(friends):  # проходим по списку друзей из словарей
        if fr_elem.get('id') == num_id:  # находим значение по ключу 'id' и сравнение
            print('%s friends: %s ' % (user, fr_elem.get('name')))


def recursive(obj):
    if isinstance(obj, dict):
        if obj.get(tags) and obj.get(friends) and (user in obj.get(tags)):# находим ключи
             # 'tags', 'friends', и в списке 'tags' имя заданное в USER
             # Порядок важен!: user - последним
            find(obj)
        for key, value in obj.items():
            recursive(value)
    elif isinstance(obj, list):
        for item in obj:
            recursive(item)
    else:
        pass

recursive(json_obj)
