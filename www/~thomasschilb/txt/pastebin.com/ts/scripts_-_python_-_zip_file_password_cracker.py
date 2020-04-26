#!/usr/bin/env python
import os
import sys
import zipfile
import optparse
from threading import Thread
if os.getuid() != 0: 
  print 'requires root privileges.'
  sys.exit(1) 
def extract(zipFile, zippassword):
	try:
		zipFile.extractall(pwd=zippassword)
		print '[+] password Found' + ':' + zippassword + '\n'
	except:
		pass
def main():
	parser = optparse.OptionParser("usage "+"-z <zipfile> -d <dictionary>")
	parser.add_option('-z', dest='zipname', type='string', help='specify zip file')
	parser.add_option('-d', dest='dicname', type='string', help='specify dictionary file')
	(options, args) = parser.parse_args()
	if (options.zipname == None) | (options.dicname == None):
		print parser.usage
		exit(0)
	else:
		zipname = options.zipname
		dicname = options.dicname
		zipFile = zipfile.ZipFile(zipname)
		zippassFile = open(dicname)
		for line in zippassFile.readlines():
			zippassword = line.strip('\n')
			t = Thread(target=extract, args=(zipFile, zippassword))
			t.start()
if __name__ == '__main__':
	main()