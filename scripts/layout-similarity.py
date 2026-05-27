#!/usr/bin/env python3
"""Layout Structure Similarity — scores a clone's structural fidelity against an origin.

Compares section bounding boxes (x, y, w, h) between origin and clone. Both are
gathered by running headless playwright against each URL with a CSS selector list
mapping origin selectors to clone selectors.

Score: weighted IoU + dimension match across declared sections. Range 0..100.

Usage:
  python3 scripts/layout-similarity.py <origin-sections.json> <clone-sections.json>

JSON format:
{
  "docW": 1204, "docH": 3417,
  "sections": [
    {"name": "top-bar", "x": 0, "y": 0, "w": 1204, "h": 88, "weight": 1.0},
    ...
  ]
}
"""
import json, sys

def section_score(o, c):
    """Score one section pair. Returns dict with components."""
    # Position score: how close y-coordinate is (normalized by page height 3417)
    y_diff = abs(o["y"] - c["y"])
    y_score = max(0.0, 1.0 - y_diff / 200.0)  # 200px tolerance = 0 score

    # Width score
    w_diff = abs(o["w"] - c["w"])
    w_score = max(0.0, 1.0 - w_diff / max(o["w"], 1))

    # Height score
    h_diff = abs(o["h"] - c["h"])
    h_score = max(0.0, 1.0 - h_diff / max(o["h"], 1))

    # Aspect ratio score (h/w ratio similarity)
    o_ar = o["h"] / max(o["w"], 1)
    c_ar = c["h"] / max(c["w"], 1)
    ar_diff = abs(o_ar - c_ar)
    ar_score = max(0.0, 1.0 - ar_diff / max(o_ar, 0.01))

    # Combined: y(35) + w(15) + h(30) + ar(20)
    combined = 0.35 * y_score + 0.15 * w_score + 0.30 * h_score + 0.20 * ar_score
    return {"y": y_score, "w": w_score, "h": h_score, "ar": ar_score, "combined": combined,
            "y_diff": y_diff, "w_diff": w_diff, "h_diff": h_diff}


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    with open(sys.argv[1]) as f: origin = json.load(f)
    with open(sys.argv[2]) as f: clone = json.load(f)

    print(f"Origin: docW={origin['docW']} docH={origin['docH']}")
    print(f"Clone:  docW={clone['docW']} docH={clone['docH']}")

    # docH score
    doc_h_diff = abs(origin["docH"] - clone["docH"])
    doc_h_score = max(0.0, 1.0 - doc_h_diff / origin["docH"])
    doc_w_diff = abs(origin["docW"] - clone["docW"])
    doc_w_score = max(0.0, 1.0 - doc_w_diff / origin["docW"])
    print(f"\nDocument-level:")
    print(f"  W diff: {doc_w_diff}  score={doc_w_score*100:.1f}%")
    print(f"  H diff: {doc_h_diff}  score={doc_h_score*100:.1f}%")

    # Match sections by name
    o_by_name = {s["name"]: s for s in origin["sections"]}
    c_by_name = {s["name"]: s for s in clone["sections"]}
    common = [n for n in o_by_name if n in c_by_name]
    missing = [n for n in o_by_name if n not in c_by_name]

    print(f"\nPer-section ({len(common)} matched, {len(missing)} missing):")
    print(f"  {'name':>14}  {'y_orig':>7} {'y_clone':>7}  {'h_orig':>6} {'h_clone':>6}  {'y_s':>6} {'h_s':>6} {'comb':>6}")

    total_weight = 0.0
    weighted_sum = 0.0
    for name in common:
        o = o_by_name[name]
        c = c_by_name[name]
        w = o.get("weight", 1.0)
        s = section_score(o, c)
        total_weight += w
        weighted_sum += w * s["combined"]
        print(f"  {name:>14}  {o['y']:>7.0f} {c['y']:>7.0f}  {o['h']:>6.0f} {c['h']:>6.0f}  "
              f"{s['y']*100:>5.1f}% {s['h']*100:>5.1f}% {s['combined']*100:>5.1f}%")

    # Penalty for missing sections
    for name in missing:
        o = o_by_name[name]
        w = o.get("weight", 1.0)
        total_weight += w
        # contributes 0
        print(f"  {name:>14}  MISSING (score=0)")

    sec_score = weighted_sum / total_weight if total_weight else 0

    # Overall: 25% docW + 25% docH + 50% sections
    overall = 0.25 * doc_w_score + 0.25 * doc_h_score + 0.50 * sec_score
    print(f"\n=== Layout Structure Similarity ===")
    print(f"  Section-weighted: {sec_score*100:.2f}%")
    print(f"  Doc width:        {doc_w_score*100:.2f}%")
    print(f"  Doc height:       {doc_h_score*100:.2f}%")
    print(f"  Overall:          {overall*100:.2f}%")
    return overall

if __name__ == "__main__":
    main()
