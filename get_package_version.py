#! /usr/bin/env python3

import xml.etree.ElementTree

package = xml.etree.ElementTree.parse("package.xml")
version = package.findall("./version")[0].text
print(version)