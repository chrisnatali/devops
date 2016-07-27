import json
import sys
import argparse
import re

parser = argparse.ArgumentParser(description='Get values from docker inspect output')
parser.add_argument('attribute_paths', type=str, nargs='+',
                    help='attribute path in form of \"ancestor1.ancestor2 ... parent.value\"')

args = parser.parse_args()

obj = json.load(sys.stdin)

def get_attribute(root_dict, attr_path):
    if "." not in attr_path:
        return root_dict[attr_path]
    else:
        next_attr_start = attr_path.find(".")
        next_dict = root_dict[attr_path[:next_attr_start]]
        next_attr = attr_path[next_attr_start+1:]
        return get_attribute(next_dict, next_attr)

root_dict = obj[0]
print(" ".join([get_attribute(root_dict, attr_path) 
                for attr_path in args.attribute_paths]))
