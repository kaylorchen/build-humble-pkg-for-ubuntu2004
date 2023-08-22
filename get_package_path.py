#! /usr/bin/env python3
import os
def split_file_by_line(file_name, split_lines):
    split_files = []
    file_idx = 1
    line_ct = 0
    with open(file_name, 'r', encoding='utf-8') as fin:
        for line in fin:
            if line_ct == 0:
                part_file = file_name + str(file_idx)
                fout = open(part_file, 'w', encoding='utf-8')
                split_files.append(part_file)
            fout.write(line)
            line_ct += 1
            if line_ct >= split_lines:
                line_ct = 0
                fout.close()
                file_idx += 1
    print(f'file: {file_name}, split lines: {split_lines}, split files num: {len(split_files)}')
    return split_files
def finder(pattern, root='.'):
    matches = []
    dirs = []
    for x in os.listdir(root):
        nd = os.path.join(root, x)
        if os.path.isdir(nd):
            dirs.append(nd)
        elif os.path.isfile(nd) and pattern in x:
            matches.append(nd)
    for match in matches:
            print(match)
            print(os.path.dirname(match), file=f)
    for dir in dirs:
            finder(pattern, root=dir)
f = open('packages-path.txt', 'w+')
finder('package.xml',root='./src')
f.close()
os.system("sort packages-path.txt -o packages-path.txt")
count = len(open('packages-path.txt', 'r').readlines())
print(count)
split_file_by_line('packages-path.txt', count/20)