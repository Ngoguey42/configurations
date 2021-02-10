> My dirty nodes

A very similar document: https://github.com/ocaml-bench/notes/blob/master/profiling_notes.md

---

## Instruments with OCaml

TLDR; doesn't work.

After installing all those xcode and instruments stuff, you will be able to launch a command from xcode's window or using something like that `dune build ./bench/irmin-pack/tree.exe && time xcrun xctrace record --template 'Time Profiler' --launch -- _build/default/bench/irmin-pack/tree.exe --suite slow_trace && open *.trace`.

The generated trace is very dirty, my guess is that the frame pointers are not clean enough for Instruments, and ocaml's `+fp` switches are not supported on macos AFAICT.

### Urls
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

## Perf

> aka perf_events

Official linux profiler

### OCaml

```sh
dune build -- ./bench/irmin-pack/tree.exe && time perf record -F `cat /proc/sys/kernel/perf_event_max_sample_rate` --call-graph dwarf ./_build/default/bench/irmin-pack/tree.exe

perf script -i ./perf.data | tee perf.txt | ../FlameGraph/stackcollapse-perf.pl | ../FlameGraph/flamegraph.pl > perf.svg

# perf.data can be used to visualise the trace using `perf report`. Press `h` to see help.
# perf.txt can be passed to `speedscope`, but use a smaller frequency than the max one
# perf.svg can be opened in browser
```

I didn't spot much differences between `-F <max> --call-graph dwarf` on a normal switch and `-F <max> --call-graph fp` on a `+fp` switch.

To find a line from a symbol
```
addr2line -e _build/default/bench/irmin-pack/tree.exe  `objdump -t _build/default/bench/irmin-pack/tree.exe  | grep "__set__to_seq_from" | cut -f1 -d' '`
```

### Kernel Recipes 2017 - Perf in Netflix - Brendan Gregg

> https://www.youtube.com/watch?v=UVM3WX8Lq2k

### Urls
- Speedscope: Importing from perf (linux)
    - 2018
    - https://github.com/jlfwong/speedscope/wiki/Importing-from-perf-(linux)
- [ANN] perf demangling of OCaml symbols (& a short introduction to perf)
    - 2021
    - https://discuss.ocaml.org/t/ann-perf-demangling-of-ocaml-symbols-a-short-introduction-to-perf/7143
- http://www.brendangregg.com/perf.html#OneLiners

---

## Speedscope

> https://github.com/jlfwong/speedscope/

A browser application to visualize traces. 

Among the many features. Pressing `r` is nice to collapse the recursive call for non-tail-recursive functions. Selecting a function in the `sandwich` mode allows to see both the callees and the callers.

Doesn't seem to work when traces are over 1GB.

---

## Coz

> https://github.com/plasma-umass/coz
> https://cacm.acm.org/magazines/2018/6/228044-coz/fulltext?mobile=false

To speed up concurrent code by placing C macros calls throughout your code.

### "Performance Matters" by Emery Berger

> https://www.youtube.com/watch?v=r-TLSBdHe1A

The Layout of a tranlated program is source of a lot of variance in the performances. 

He is selling `stabilizer`, it randomizes layout. You now have a gaussian for your performances. It randomizes the layout twice per second during execution too.

Virtual speedup: In concurrent program, to find out the impact of a speed up, slow down components one by one and see the impact on the total time. Sometime, speeding a component slows the total because of new congestions.

---

## Flamegraph

> http://brendangregg.com/flamegraphs.html

Check out the shortcuts. The highlighting search is nice.

### USENIX ATC '17: Visualizing Performance with Flame Graphs

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
Bugs in traces
- Mangled RBP register, frame-pointer

Command line
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

### Urls
- http://www.lix.polytechnique.fr/Labo/Gabreil.Scherer/doc/chameau-sur-le-plateau/2019-11-12-jacques-henri-jourdan-statmemprof.pdf
- https://github.com/jhjourdan/statmemprof-emacs
- https://blog.janestreet.com/finding-memory-leaks-with-memtrace/
- https://github.com/janestreet/memtrace
- https://github.com/janestreet/memtrace_viewer

---

## Unsolved problems
- Any other alternatives to speedscope? Some desktop apps could exist
- How to make sense out of Lwt fibers reordering that might occur sometimes.
- How to hide collapse some parts of the call stack? Like OCaml's GC
- How to simply process the raw data programmatically to produce ad-hoc high level infos, maybe using python.

--

## Unexplored tools
- landmarks (deprec ated?)
- ocamlperf
- ocaml spacetime (kind of the ancestor of memprof/memtrace)
    - https://blog.janestreet.com/a-brief-trip-through-spacetime/
- memthol
    - https://www.ocamlpro.com/2020/12/01/memthol-exploring-program-profiling/
- valgrind
- dtrace
- pprof (go only? that's unclear)
    - pprof is a tool for visualization and analysis of profiling data. 
    - https://github.com/google/pprof 
    - 4k stars
    - KC uses pprof on multicore https://discuss.ocaml.org/t/about-multicore/138/18 usable on 4.x?
- Hotspot 
    - the Linux perf GUI for performance analysis 
    - https://github.com/KDAB/hotspot 
    - 2k stars
- Tracy 
    - A real time, nanosecond resolution, remote telemetry, hybrid frame and sampling profiler for games and other applications. 
    - https://github.com/wolfpld/tracy 
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