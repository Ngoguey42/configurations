
## TODO
- Which goals clearly? (mem when, space, cpu when)
- Regarder context.ml pour voir les diffs avec tezos-log

## Unsolved problems
- How to make sense out of Lwt fiber reordering that might occur sometimes
- How to produce a map file from symbols to file/line
- How to hide collapse some parts of the call stack? Like OCaml's GC
- How to simply process the raw data programmatically to produce ad-hoc high level infos, maybe using pandas.

## Observations
- In encode_bin we can clearly see the tower of height <= 32, a non-tailrec flattening tool would be great
- There is a strange non-tailrec tower of height >100 starting from tree.exe made of lru__find / pack__unsafe_find -_-'
- Lru find calls Ht.find twice with the same key
- Inode.add is 40% of the time used
  - I don't understand the lazy.force but the slow Map.add may come from `let vs = StepMap.bindings (StepMap.add s v vs) in`
  - 71% in Tree.?
    - 17% on inode_aux
      - 13% on Lazy.force
        - 7% in stabilize's hash call (the one that call `list`)
          - 4% in map.add
    - 21% on Pack.unsafe_append
  - 27% in Tree.?
    - 15% in Tree.find


> My dirty nodes

A very similar documents: https://github.com/ocaml-bench/notes/blob/master/profiling_notes.md

---

## Profiling OCaml on macos using Instruments

TLDR; doesn't work.

After installing all those xcode and instruments stuff, you will be able to launch a process from xcode's window or using something like that `dune build ./bench/irmin-pack/tree.exe && time xcrun xctrace record --template 'Time Profiler' --launch -- _build/default/bench/irmin-pack/tree.exe --suite slow_trace && open *.trace`.

The generated trace is very dirty, my guess is that the frame pointers are not clean enough for Instruments, and ocaml `+fp` switches are not supported on macos.

Urls:
- Instruments Tutorial with Swift: Getting Started
    - 2021
    - https://www.raywenderlich.com/16126261-instruments-tutorial-with-swift-getting-started#:~:text=The%20Call%20Tree%20shows%20the,profiler%20stops%20in%20each%20method.
- Speedscope: Importing from Instruments.app
    - 2020
    - https://github.com/jlfwong/speedscope/wiki/Importing-from-Instruments.app
    - Note: Use drag and drop, don't use the `Browse` button
    - Note: The `.trace` files didn't work, I had to use the `deep copy` trick
- Flame Graphs for Instruments
    - 2012
    - https://schani.wordpress.com/2012/11/16/flame-graphs-for-instruments/

---

## Profiling OCaml on linux using perf, flamegraph, speedscope

```
dune build -- ./bench/irmin-pack/tree.exe && time perf record -F `cat /proc/sys/kernel/perf_event_max_sample_rate` --call-graph dwarf ./_build/default/bench/irmin-pack/tree.exe

perf script -i ./perf.data | tee perf.txt | ../FlameGraph/stackcollapse-perf.pl | ../FlameGraph/flamegraph.pl > perf.svg

# perf.data can be used to visualise the trace using `perf report`. Press `h` to see help.
# perf.txt can be passed to `speedscope`, but use a smaller frequency than the max one
# perf.svg can be opened in browser
```

I didn't spot much differences between `-F <max> --call-graph dwarf` on a normal switch and `-F <max> --call-graph fp` on a `+fp` switch.

Urls:
- Speedscope: Importing from perf (linux)
    - 2018
    - https://github.com/jlfwong/speedscope/wiki/Importing-from-perf-(linux)
- [ANN] perf demangling of OCaml symbols (& a short introduction to perf)
    - 2021
    - https://discuss.ocaml.org/t/ann-perf-demangling-of-ocaml-symbols-a-short-introduction-to-perf/7143

---

## USENIX ATC '17: Visualizing Performance with Flame Graphs

> https://www.youtube.com/watch?v=D53T1Ejig1Q

#### CPU Flame graphs

Time sampling
- Low overhead
- Not great accuracy.

A FG visualizes a collection of stack traces
- x: alphabetical sort (not time!)
- y: stack depth

With that svg visualisation
- Zoom
- Ctr+f to highlight rectangles with KW
- Mouseover

Differential Flame Graph
- To compare 2 flame graphs
- Red, less calls
- Blue, more calls
- also: flamegraphdiff

Icicle Graph
- Merge top-down instead

Flame Charts
- As in chrome's console
- Time on the x-axis
- Only for single-threaded

#### Fixing Stacks & Symbols
Bug
- Mangled RBP register, frame-pointer

Command lines
- stackcollapse
- Instead of `perf script`, use bcc/tools/profile.py

GUI Automation
- Netflix Vector
    - https://github.com/Netflix/flamescope
    - https://github.com/grafana/grafana

#### Advanced flame graphs

You can monitor context switches to also monitor what's happening off-cpu

Disk I/O

cache-misses

CPI flame graph, whether or not it was instructions intensive (might be memory stall cycles)

Flame graph diffs
    - http://corpaul.github.io/flamegraphdiff/
    - https://github.com/corpaul/flamegraphdiff

---

## Memprof using memtrace

Urls:
- http://www.lix.polytechnique.fr/Labo/Gabreil.Scherer/doc/chameau-sur-le-plateau/2019-11-12-jacques-henri-jourdan-statmemprof.pdf
- https://github.com/jhjourdan/statmemprof-emacs
- https://blog.janestreet.com/finding-memory-leaks-with-memtrace/
- https://github.com/janestreet/memtrace
- https://github.com/janestreet/memtrace_viewer


---

## Unexplored tools
- landmarks (deprecated?)
- ocamlperf
- ocaml spacetime (kind of the ancestor of memprof/memtrace)
    - https://blog.janestreet.com/a-brief-trip-through-spacetime/
- memthol
    - https://www.ocamlpro.com/2020/12/01/memthol-exploring-program-profiling/
- valgrind
- FlameGraph
    - Flame graphs are a visualization of profiled software, allowing the most frequent code-paths to be identified quickly and accurately.
    - https://github.com/brendangregg/FlameGraph
    - http://www.brendangregg.com/flamegraphs.html
    - https://github.com/spiermar/d3-flame-graph
    - 10k stars
- pprof (go only?)
    - pprof is a tool for visualization and analysis of profiling data. 
    - https://github.com/google/pprof 
    - 4k stars
    - KC uses pprof on multicore https://discuss.ocaml.org/t/about-multicore/138/18 usable on 4.0?
- Hotspot 
    - the Linux perf GUI for performance analysis 
    - https://github.com/KDAB/hotspot 
    - 2k stars
- Tracy 
    - A real time, nanosecond resolution, remote telemetry, hybrid frame and sampling profiler for games and other applications. 
    - https://github.com/wolfpld/tracy 
    - 2k stars
- Coz 
    - Finding Code that Counts with Causal Profiling 
    - https://github.com/plasma-umass/coz 
    - 2k stars
- Orbit 
    - standalone C/C++ profiler for Windows and Linux. Its main purpose is to help developers visualize the execution flow of a complex application. 
    - https://github.com/google/orbit 
    - 1.5k stars
- remotery 
    - A realtime CPU/GPU profiler hosted in a single C file with a viewer that runs in a web browser. 
    - https://github.com/Celtoys/Remotery 
    - 1.5k stars
-  https://thlorenz.com/flamegraph/web/

---