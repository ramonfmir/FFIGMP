import Lake
open Lake DSL

package «fFIGMP» {
  srcDir := "lean"
  moreLinkArgs := #["-lgmp"]
}

lean_lib «FFIGMP»

target ffigmp.o (pkg : Package) : FilePath := do
  let oFile := pkg.buildDir / "c" / "ffigmp.o"
  let srcJob ← inputFile <| pkg.dir / "c" / "ffigmp.c"
  let flags := #["-I" ++ (← getLeanIncludeDir).toString, "-D LEAN_USE_GMP", "-fPIC"]
  buildFileAfterDep oFile srcJob (extraDepTrace := computeHash flags) fun srcFile => do
    compileO "ffigmp.c" oFile srcFile flags "gcc"

extern_lib libffigmp (pkg : Package) := do 
  let name := nameToStaticLib "ffigmp"
  let ffiO ← fetch <| pkg.target ``ffigmp.o
  buildStaticLib (pkg.buildDir / defaultLibDir / name) #[ffiO]

@[default_target]
lean_exe «fFIGMP» {
  root := `Main
}
