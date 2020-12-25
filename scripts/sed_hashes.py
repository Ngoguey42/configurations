"""
The following command...

python3 ~/configurations/sed_hashes.py "(?:^|[^a-z0-9])([a-z0-9]{40})(?:$|[^a-z0-9])"

...will `sed` stdin to stdout replacing all 40-char-long hashes (aka tokens) to
human readable first name of length 8 (or padded with ~ to reach length 8).

The provided argv[1] regex pattern should match the token in group 1.

The token/name mapping is randomized every run.

A possible improvement would be to fetch names's list of name and
deterministically translate a token to a name.

"""

import re, sys

import names

width = 8
used = set()
mapping = dict()

def get_new_name():
    """Should terminate, the `names` library contains >10_000 first names."""
    while True:
        n = names.get_first_name()
        if n in used: continue
        if len(n) > width: continue
        used.add(n)
        return n + "~" * (width - len(n))

def name_of_string(s):
    if s not in mapping:
        n = get_new_name()
        mapping[s] = n
    return mapping[s]

def sed_string(pat, s):
    l = list(re.finditer(pat, s))
    sl0 = slice(0, 0)
    chunks = []
    for m in l:
        sl2 = slice(*m.span(1))
        assert sl2.start >= 0
        assert sl2.start >= sl0.stop
        if sl2.start == sl0.stop:
            # Token is at the beginning of `s`, or 2 tokens side by side
            chunks.append(name_of_string(s[sl2]))
        else:
            # Add a token and what's before it
            sl1 = slice(sl0.stop, sl2.start)
            chunks.append(s[sl1])
            chunks.append(name_of_string(s[sl2]))
        sl0 = sl2
    assert sl0.stop <= len(s)
    if sl0.stop != len(s):
        # Trailing chars of `s` if any
        sl1 = slice(sl0.stop, len(s))
        chunks.append(s[sl1])
    return "".join(chunks)

def main():
    pat = sys.argv[1]
    while True:
        l0 = input()
        l1 = sed_string(pat, l0)
        print(l1)

try: main()
except EOFError: pass
