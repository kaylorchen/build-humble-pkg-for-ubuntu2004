#! /usr/bin/env python3

import xml.etree.ElementTree

package = xml.etree.ElementTree.parse("package.xml")
name = package.findall("./name")[0].text
print(name)