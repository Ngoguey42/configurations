#!/bin/zsh
Hello () {
if [ $# -eq 0 ]
then
	/cygdrive/e/Program\ Files\ \(x86\)/Notepad++/notepad++.exe
else
	/cygdrive/e/Program\ Files\ \(x86\)/Notepad++/notepad++.exe `cygpath -aw $@`
fi
}
Hello $@
