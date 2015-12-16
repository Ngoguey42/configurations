 let () =
    try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
        with Not_found -> ()
;;
#use "topfind"
#thread
#require "dynlink"
#camlp4o
#require "bin_prot.syntax"
#require "sexplib.syntax"
#require "variantslib.syntax"
#require "fieldslib.syntax"
#require "comparelib.syntax"
#require "core"
#require "core.top"
