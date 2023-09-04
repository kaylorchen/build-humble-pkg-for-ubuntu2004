#!/usr/bin/env python3
import yaml
import argparse
import os
import apt
import copy

def save_dict_to_yaml(dict_value: dict, save_path: str):
    with open(save_path, 'w') as file:
        file.write(yaml.dump(dict_value, allow_unicode=True))

def argparse_repos():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cfg',type = str,default=r"ros2_release_humble.repos",help="...") # a.yaml中内容在文章开始给出
    args = parser.parse_args()
    filepath = os.path.join(os.getcwd(), args.cfg)
    return filepath

with open(argparse_repos(), 'r') as f:
  # config =  yaml.load(f, Loader=yaml.FullLoader)
    config = yaml.safe_load(f)
update_config = copy.deepcopy(config)
cache = apt.Cache()
for pkg in config.get('repositories').keys():
  try:
    tmp = cache[pkg]
    if tmp.candidate:
      # print(pkg + ' is available, skipping')
      update_config.get('repositories').pop(pkg)
  except:
    print(pkg + ' is not available, and need to compile')
# print(config)
# print(update_config)
save_dict_to_yaml(update_config, './updates.repos')