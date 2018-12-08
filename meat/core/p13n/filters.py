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
