import os
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
f = open('packages-path.txt', 'w')
finder('package.xml',root='./src')
f.close()