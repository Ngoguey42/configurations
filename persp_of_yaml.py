import argparse
import sys
from pprint import pprint
import os
import collections

import yaml
import numpy as np

np.set_printoptions(linewidth=300)

UP_TOKEN = "<up>"
LEFT_TOKEN = "<left>"
SPECIAL_TOKENS = [UP_TOKEN, LEFT_TOKEN]
missing_files = set()

# Step 1 - Read yaml and clean file paths ******************************************************* **
def read(yamlpath):
    data = open(yamlpath, 'r').read()
    data = yaml.load(data, Loader=yaml.FullLoader)
    yamldir = os.path.dirname(os.path.abspath(yamlpath))

    def normalize_buffer_path(p):
        if p in SPECIAL_TOKENS:
            return p
        elif isinstance(p, (str, int, float)):
            q = os.path.normpath(os.path.join(yamldir, str(p)))
            if not os.path.exists(q):
                missing_files.add(q)
            return q
        else:
            assert False, "bad buffer:\n{!s}".format(p)

    def normalize_buffer_matrix(matrix):
        assert isinstance(matrix, list), 'bad matrix:\n{!s}'.format(matrix)
        assert all(isinstance(row, list) for row in matrix), 'bad type:\n{!s}'.format(matrix)
        assert len(set(len(row) for row in matrix)) <= 1, 'bad row length:\n{!s}'.format(matrix)
        return tuple([
            tuple([normalize_buffer_path(p) for p in row])
            for row in matrix
        ])

    perspectives = {
        k: normalize_buffer_matrix(matrix)
        for k, matrix in data["perspectives"].items()
        for k in [str(k)]
    }
    return {"perspectives": perspectives}

# Step 2 - Allocate buffernames ***************************************************************** **
def allocate_buffernames(data):
    filepaths = set(
        filepath
        for matrix in data["perspectives"].values()
        for row in matrix
        for filepath in row
        if filepath not in SPECIAL_TOKENS
    )
    def buffernames_of_filepath(p):
        chunks = p.split(os.sep)
        assert len(chunks) > 0, "Path too small"
        fname = chunks[-1]
        dirnames = chunks[:-1]
        return tuple([
            fname + suffix
            for count in range(0, len(dirnames) + 1)
            for suffix in ["" if count == 0 else '<{}>'.format(os.sep.join(dirnames[-count:]))]
        ])
    buffernames_per_filepath = {
        filepath: buffernames_of_filepath(filepath)
        for filepath in filepaths
    }
    buffername_count = collections.Counter([
        buffername
        for buffernames in buffernames_per_filepath.values()
        for buffername in buffernames
    ])
    buffername_per_filepath = {
        filepath: next(
            buffername
            for buffername in buffernames
            if buffername_count[buffername] == 1
        )
        for filepath, buffernames in buffernames_per_filepath.items()
    }
    return buffername_per_filepath

# Step 3 - Create a higher lvl representation for each persp ************************************ **
class Perspective:
    def __init__(self, shortcut, matrix, buffername_per_filepath):
        filepaths = [v for row in matrix for v in row if v not in SPECIAL_TOKENS]
        buffernames = [buffername_per_filepath[path] for path in filepaths]
        unique_filepaths, unique_buffernames = zip(*set(zip(filepaths, buffernames)))

        count = len(filepaths)
        h = len(matrix)
        w = 0 if h == 0 else len(matrix[0])

        k = 0
        arr = np.asarray(matrix, object)
        for (i, j), path in np.ndenumerate(arr):
            if path == UP_TOKEN:
                assert i > 0, "Can't use up token on top-most line"
                assert isinstance(arr[i - 1, j], int), 'bug'
                arr[i, j] = arr[i - 1, j]
            elif path == LEFT_TOKEN:
                assert j > 0, "Can't use left token on left-most line"
                assert isinstance(arr[i, j - 1], int), 'bug'
                arr[i, j] = arr[i, j - 1]
            else:
                arr[i, j] = k
                k = k + 1
        arr = arr.astype(int)

        self.shortcut = shortcut
        self.filepaths = filepaths
        self.buffernames = buffernames
        self.unique_filepaths = unique_filepaths
        self.unique_buffernames = unique_buffernames
        self.count = count
        self.h = h
        self.w = w
        self.arr = arr

    def __str__(self):
        a = '\n          '.join([
            '{} {}'.format(i, bn)
            for i, bn in enumerate(self.buffernames)
        ])
        b = str(self.arr).replace('\n', '\n          ')
        return "shortcut: {}\nlayout:   {}\nbuffers:  {}".format(self.shortcut, b, a)

# Step 4 - Expand perspectives to python primitives ********************************************* **
class String:
    def __init__(self, s):
        self.s = s

    def __str__(self):
        return self.s

def majormode_of_buffername(path):
    if os.path.isdir(path):
        return "dired-mode"
    lhs, rhs = os.path.splitext(path)
    if lhs == "Dockerfile":
        return "dockerfile-mode"
    rhs = rhs.replace(".", "")
    d = collections.defaultdict(
        lambda: "fundamental-mode",
        py="python-mode",
        ml="tuareg-mode",
        mli="tuareg-mode",
        md="markdown-mode",
        js="web-mode",
        html="web-mode",
        php="web-mode",
        htm="web-mode",
        css="web-mode",
        c="c-mode",
        yaml="yaml-mode",
        yml="yaml-mode",
        json="yaml-mode",
        txt="text-mode",
    )
    return d[rhs]

def buffers(persp):
    return [
        ["def-buffer", String(buffername), String(filepath), majormode_of_buffername(filepath)]
        for buffername, filepath in zip(persp.unique_buffernames, persp.unique_filepaths)
    ]

def minimums(persp):
    return [
        ["min-height", ...,  4 * persp.h],
        ["min-width", ..., 10 * persp.w],
        ["min-height-ignore", ...,  2 * persp.h],
        ["min-width-ignore", ...,  2 * persp.w],
        ["min-height-safe", ...,  1 * persp.h],
        ["min-width-safe", ...,  2 * persp.w],
        ["min-pixel-height", ...,  4 * persp.h],
        ["min-pixel-width", ..., 10 * persp.w],
        ["min-pixel-height-ignore", ...,  2 * persp.h],
        ["min-pixel-width-ignore", ...,  2 * persp.w],
        ["min-pixel-height-safe", ...,  1 * persp.h],
        ["min-pixel-width-safe", ...,  2 * persp.w],
    ]

def split_slice_vertically(persp, slices0):
    hslice0, wslice0 = slices0
    arr0 = persp.arr[slices0]
    h0 = hslice0.stop - hslice0.start
    w0 = wslice0.stop - wslice0.start

    stops = []
    for i in range(1, h0):
        slices_a = slice(0, i), slice(0, w0)
        slices_b = slice(i, None), slice(0, w0)
        splits_a = set(arr0[slices_a].flatten().tolist())
        splits_b = set(arr0[slices_b].flatten().tolist())
        if splits_a.isdisjoint(splits_b):
            stops.append(i)

    slices1 = [
        (slice(hslice0.start + start, hslice0.start + stop), wslice0)
        for start, stop in zip([0] + stops, stops + [h0])
    ]
    return slices1

def split_slice_horizontally(persp, slices0):
    hslice0, wslice0 = slices0
    arr0 = persp.arr[slices0]
    h0 = hslice0.stop - hslice0.start
    w0 = wslice0.stop - wslice0.start

    stops = []
    for i in range(1, w0):
        slices_a = slice(0, h0), slice(0, i)
        slices_b = slice(0, h0), slice(i, None)
        splits_a = set(arr0[slices_a].flatten().tolist())
        splits_b = set(arr0[slices_b].flatten().tolist())
        if splits_a.isdisjoint(splits_b):
            stops.append(i)

    slices1 = [
        (hslice0, slice(wslice0.start + start, wslice0.start + stop))
        for start, stop in zip([0] + stops, stops + [w0])
    ]
    return slices1

def split_dimensions(persp, slices, nh, nw):
    h0, w0 = slices[0].stop - slices[0].start, slices[1].stop - slices[1].start
    return [
        ["pixel-width", ..., w0],
        ["pixel-height", ..., h0],
        ["total-width", ..., w0],
        ["total-height", ..., h0],
        ["normal-height", ..., nh],
        ["normal-width", ...,  nw],
    ]

def buffer_placement(persp, idx):
    selected = ["selected", ..., True] if idx == 0 else ["selected"]
    return [
        "buffer", String(persp.buffernames[idx]), selected,
        ["hscroll", ..., 0],
        ["fringes", 0, 0, None],
        ["margins", None],
        ["scroll-bars", None, 0, True, None, 0, True],
        ["vscroll", ..., 0],
        ["dedicated"],
        ["point", ..., 1],
        ["start", ..., 1],
    ]

def split(persp, is_last, slices, nh, nw):
    buffers = sorted(set(persp.arr[slices].flatten().tolist()))
    count = len(buffers)
    h0, w0 = slices[0].stop - slices[0].start, slices[1].stop - slices[1].start
    is_last = [] if not is_last else [["last", ..., True]]

    if count == 1:
        return [
            "leaf", *is_last, *split_dimensions(persp, slices, nh, nw),
            buffer_placement(persp, buffers[0]),
        ]
    else:
        vslices = split_slice_vertically(persp, slices)
        hslices = split_slice_horizontally(persp, slices)
        assert len(vslices) * len(hslices) >= 1, "Can't have an empty persp"
        if len(vslices) > 1:
            return [
                "vc", *is_last, *split_dimensions(persp, slices, nh, nw),
                ["combination-limit"],
                *[
                    split(persp, (i + 1 == len(vslices)), s,
                          (s[0].stop - s[0].start) / h0, (s[1].stop - s[1].start) / w0)
                    for i, s in enumerate(vslices)
                ]
            ]
        elif len(hslices) > 1:
            return [
                "hc", *is_last, *split_dimensions(persp, slices, nh, nw),
                ["combination-limit"],
                *[
                    split(persp, (i + 1 == len(hslices)), s,
                          (s[0].stop - s[0].start) / h0, (s[1].stop - s[1].start) / w0)
                    for i, s in enumerate(hslices)
                ]
            ]
        else:
            assert False, "This persp can't be represented:\n{}".format(persp)

def wconf(persp):
    h, w = persp.h, persp.w
    return [
        "def-wconf",
        [minimums(persp), *split(persp, False, (slice(0, h), slice(0, w)), 1., 1.)]
    ]

def persp(i, persp):
    return [
        "def-persp", String(persp.shortcut), buffers(persp), wconf(persp), ["def-params", None],
        True if i == 0 else None, None, None
    ]

def expand(perspectives):
    return [
        persp(i, p)
        for i, p in enumerate(perspectives)
    ]

# Step 4 - Strigify python primitives to lisp *************************************************** **
def stringify(o):
    if isinstance(o, list):
        assert len(o) != 0, "Can't have an empty list"
        head = '('
        elements = [stringify(p) for p in o]
        tail = ')'
        return '{}{}{}'.format(head, ' '.join(elements), tail)
    elif o is True:
        return 't'
    elif isinstance(o, (float, int, str)):
        return str(o)
    elif isinstance(o, String):
        return '"{}"'.format(o)
    elif isinstance(o, type(None)):
        return 'nil'
    elif isinstance(o, type(...)):
        return '.'
    else:
        assert False, 'unknown primitive type: {}'.format(type(o))

# Step 5 - Print shell code to mkdir / touch missing files ************************************** **
def print_missings():
    missing_dirs = set()
    for p in missing_files:
        prefixes = p.split(os.sep)[:-1]
        for count in range(1, len(prefixes) + 1):
            q = '/'.join(prefixes[:count])
            if not q:
                continue
            if not os.path.exists(q):
                missing_dirs.add(q)
    if missing_files:
        print("Missing files! You should:", file=sys.stderr)
    for p in missing_dirs:
        print("mkdir -p {}".format(p), file=sys.stderr)
    for p in missing_files:
        print("touch {}".format(p), file=sys.stderr)

# Main ****************************************************************************************** **
def main(args=sys.argv[1:]):
    p = argparse.ArgumentParser()
    p.add_argument("yaml_path")
    args = p.parse_args(args)
    data = read(args.yaml_path)
    buffername_per_filepath = allocate_buffernames(data)
    perspectives = [
        Perspective(k, matrix, buffername_per_filepath)
        for k, matrix in data["perspectives"].items()
    ]
    sexpr_python = expand(perspectives)
    s = stringify(sexpr_python)
    print(s)
    print_missings()

if __name__ == "__main__":
    main()
