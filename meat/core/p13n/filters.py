import struct
import codecs

def nohash (hex):
  return hex.lstrip('#')

def to_hex (i):
  return '%0.4X' % i

def to_win_color (hex):
  hex = nohash(hex)
  return '00' + hex[4:6] + hex[2:4] + hex[0:2]

def to_gnome_color (hex):
  hex = nohash(hex)
  return '#' + hex[0:2]*2 + hex[2:4]*2 + hex[4:6]*2

def to_rgb (hex):
  return struct.unpack('BBB', codecs.decode(nohash(hex), 'hex'))

# <dict> ... </dict>
def to_iterm_dict (hex):
  return """<dict>
    <key>Alpha Component</key>
    <real>1</real>
    <key>Color Space</key>
    <string>sRGB</string>
    <key>Red Component</key>
    <real>{}</real>
    <key>Green Component</key>
    <real>{}</real>
    <key>Blue Component</key>
    <real>{}</real>
  </dict>""".format(*(x / 255.0 for x in to_rgb(hex)))
