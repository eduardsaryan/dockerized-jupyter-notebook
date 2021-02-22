#!/usr/bin/python3
from IPython.lib import passwd
print (passwd('$PASSWORD'))


#!/usr/bin/python3
import sys
import hashlib

script,string = sys.argv
encrypted = hashlib.sha1(bytes(string, 'utf-8')).hexdigest()

print("Encrypted string for {0} is: {1}".format(string, encrypted))


# SHA1 examples
JvFuCmqpLVjvQ5fv39tG

sha1:c0217d26293d:557b7e726da9b4a91d02a9acbe95bec6fc6a4107
sha1:538109ae435d:4e40c47b515db7c021753c64a267f469722c5955
