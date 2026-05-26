#!/usr/bin/env python3
"""Segment-weighted similarity computation.

Splits both images into named regions, computes per-region odiff,
weights each by importance, and returns a single weighted-average
similarity number. IP-placeholder regions (portraits, IP-sensitive
SVG slots) can be assigned low weights or excluded entirely.

Usage:
    segment-similarity.py <origin.png> <clone.png> <regions.json>

regions.json format:
    {
      "segments": [
        {"name": "top-bar", "x": 0, "y": 40, "w": 450, "h": 50, "weight": 1.2},
        ...
      ]
    }
"""
import json
import os
import re
import subprocess
import sys
import tempfile

MAGICK = '/opt/homebrew/bin/magick'
ODIFF = '/opt/homebrew/bin/odiff'


def odiff(img1, img2, out):
    r = subprocess.run([ODIFF, img1, img2, out], capture_output=True, text=True)
    line = r.stdout + r.stderr
    if 'different pixels' in line:
        m = re.search(r'\(([\d.]+)%\)', line)
        if m:
            return 100.0 - float(m.group(1))
    if 'Identical' in line or 'No diff' in line:
        return 100.0
    return None


def crop(src, x, y, w, h, out):
    subprocess.run([MAGICK, src, '-crop', f'{w}x{h}+{x}+{y}', out], check=True)


def main():
    if len(sys.argv) < 4:
        print('Usage: segment-similarity.py <origin.png> <clone.png> <regions.json>', file=sys.stderr)
        sys.exit(1)
    origin, clone, regions_file = sys.argv[1], sys.argv[2], sys.argv[3]
    with open(regions_file) as f:
        cfg = json.load(f)

    with tempfile.TemporaryDirectory() as tmp:
        total_w = 0.0
        total_s = 0.0
        print(f"{'segment':<18} {'rect':<24} {'odiff':>8}  {'weight':>6}  {'wscore':>8}")
        print('-' * 70)
        for seg in cfg['segments']:
            name = seg['name']
            x, y, w, h = seg['x'], seg['y'], seg['w'], seg['h']
            weight = seg.get('weight', 1.0)
            if weight <= 0:
                print(f"{name:<18} ({x:3},{y:3} {w:3}x{h:3})  excluded")
                continue
            o = os.path.join(tmp, f'{name}-o.png')
            c = os.path.join(tmp, f'{name}-c.png')
            d = os.path.join(tmp, f'{name}-d.png')
            crop(origin, x, y, w, h, o)
            crop(clone,  x, y, w, h, c)
            s = odiff(o, c, d)
            if s is None:
                print(f"{name:<18} ({x:3},{y:3} {w:3}x{h:3})  ERROR")
                continue
            ws = s * weight
            print(f"{name:<18} ({x:3},{y:3} {w:3}x{h:3})  {s:6.2f}%  {weight:5.2f}  {ws:7.2f}")
            total_s += ws
            total_w += weight
        print('-' * 70)
        if total_w > 0:
            final = total_s / total_w
            print(f"Weighted similarity: {final:.2f}%")
            print(f"WEIGHTED_SIMILARITY={final:.2f}")


if __name__ == '__main__':
    main()
