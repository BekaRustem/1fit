#!/usr/bin/env python3
"""Generate the app icon (dumbbell) as a PNG, embed it into index.html."""
import zlib, struct, base64, os

S = 180
BG = (11, 15, 20)      # #0B0F14
AC = (52, 211, 153)    # #34D399

# dumbbell rectangles (x0,y0,x1,y1), symmetric about x=90, y=90
rects = [
    (58, 84, 122, 96),    # bar
    (50, 72, 60, 108),    # inner plate L
    (120, 72, 130, 108),  # inner plate R
    (40, 64, 50, 116),    # outer plate L
    (130, 64, 140, 116),  # outer plate R
    (34, 74, 40, 106),    # cap L
    (140, 74, 146, 106),  # cap R
]

def inside(x, y):
    for (x0, y0, x1, y1) in rects:
        if x0 <= x < x1 and y0 <= y < y1:
            return True
    return False

raw = bytearray()
for y in range(S):
    raw.append(0)  # filter type 0
    for x in range(S):
        r, g, b = AC if inside(x, y) else BG
        raw += bytes((r, g, b, 255))

def chunk(tag, payload):
    c = tag + payload
    return struct.pack(">I", len(payload)) + c + struct.pack(">I", zlib.crc32(c) & 0xffffffff)

png = b"\x89PNG\r\n\x1a\n"
png += chunk(b"IHDR", struct.pack(">IIBBBBB", S, S, 8, 6, 0, 0, 0))
png += chunk(b"IDAT", zlib.compress(bytes(raw), 9))
png += chunk(b"IEND", b"")

datauri = "data:image/png;base64," + base64.b64encode(png).decode()

here = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(here, "icon-180.png"), "wb") as f:
    f.write(png)
with open(os.path.join(here, "app_template.html")) as f:
    html = f.read()
html = html.replace("__ICON__", datauri)
with open(os.path.join(here, "index.html"), "w") as f:
    f.write(html)
print("index.html written:", len(html), "bytes; icon", len(png), "bytes")
