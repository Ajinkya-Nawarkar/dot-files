#
# cppcmd.sh: shell helper aliases/functions for C++ curriculum (Foundation C++
#            and C++ for Experienced Developers)

# Edit FBASE path below, and source this file from your .profile 
#            (for example, if you place cppcmd.sh in your home directory,
#             then include the command
#               . ./cppcmd.sh
#             at the end of your .profile)

FBASE=/home/anawarkar/my_mbig/cpp_training  # Base dir for your C++ materials repo
                 # (Note: original name was foundational-cpp, I've renamed mine)

############################################################################
# Summary of utilities:
# (Foundational C++ only:)
#    l#:  Change to 'labs' folder for chapter # (Foundtional C++)
#    s#:  Change to lab solutions folder for chapter # (Foundational C++)
#
# (ELC++:)
#    s:   Change to nearest 'src' directory
#    b:   Change to nearest 'build' dir (below or adjacent to current dir)
#    m:   Change to nearest 'build' directory and run 'make'
#    bm:  Create build folder if needed (and run bbcmake), then run make
#    t:   Change to 'tests' directory
#    labt: Run labtests program in src/tests/labtest"
#    i:   Run incrtests command in current dir (just a shorthand)
#    bbcmakeall: Run bbcmake in all 'build' folders below current dir
#    cppcmd: Give summary of all these commands
############################################################################

#
# Foundational C++ directory navigation shortcuts:
#
# Generate aliases s#, l#, for cd-ing to the different C++ "foundational"
# chapter code directories. NOTE: All assume you've cloned the 
# foundational-cpp repo to your home directory FBASE as set below
# (I've renamed foundational-cpp to fcpp to shorten the path lengths)
#
# Examples:
# l8: ("ell"-8!) cd to chapter 8 lab exercises
# s3: cd to chapter 3 lab solutions
#
# (Note: FQuickChange must be invoked during login profile processing)
#

function FQuickChange   # Create shell aliases for l# and s# commands:
{
LBASE=$FBASE/labs
for n in 1 2 3 4 5 6 7 8 9 10
do
    n2=0$n
    [ $n == 10 ] && n2=10
    eval 'alias l'$n="'"cd $LBASE/${n2}*"'"
    eval 'alias s'$n="'"cd $LBASE/${n2}*/solns"'"
done
}

FQuickChange     # execute the function above to set up aliases

function b   # switch to build folder, below or adjacent to current dir
{
    [ -d build ] && cd build && return 0
    [ -d ../build ] && cd ../build && return 0
    [ -d ../../build ] && cd ../../build && return 0
    echo "No 'build' folder in sight." && return 1
}

function m   # run make in the build folder
{
    b || return 1
    echo
    echo
    echo "-------------------------------------------------------------------------------"
    make
}

#
# bm: make a build folder and run bbcmake ..
# OR if build folder exists, just run make in it:
#

function bm
{
    [[ $(basename $PWD) == "src" ]] && cd ..
    if [ -d build ]; then
        echo "Running make in existing build directory:"
        cd build
        make
    else
        [ ! -f CMakeLists.txt ] && echo "No CMakeLists.txt here." && return
        echo "Creating build directory and running bbcmake in it:"
        mkdir build
        cd build
        bbcmake ..
    fi
}

function s   # switch to src folder (below if not in 'build' or over if so)
{
    [[ $(basename $(dirname $PWD)) == build ]] && cd ..
    
    if [[ $(basename $PWD) == build ]]; then
        [[ -d ../src ]] && cd ../src && return
        echo "No 'src' folder sibling to this 'build' folder you're in."
    else
        [ -d src ] && cd src && return
        [ -d ../src ] && cd ../src && return
        echo "No 'src' folder in sight."
    fi
}

function t   # switch to tests folder (below if not in 'build' or over if so)
{
    [[ $(basename $(dirname $PWD)) == build ]] && cd ..
    
    if [[ $(basename $PWD) == build ]]; then
        [[ -d ../src/tests ]] && cd ../src/tests && return
        echo "No 'src/tests' folder sibling to this 'build' folder you're in."
    else
        [ -d src/tests ] && cd src/tests && return
        [ -d ../src/tests ] && cd ../src/tests && return
        echo "No 'src/tests' folder in sight."
    fi
}

alias gt=gdbtui
alias bb='b && bbcmake -64 -DCMAKE_BUILD_TYPE=RelWithDebInfo ../src'
alias bbm='bb && make'

alias i=./incrtests    # save typing

#
# labt: run the src/tests/labtest command
#

function labt
{
    if [[ -x build/src/tests/labtests ]]; then
        ./build/src/tests/labtests
    elif [[ -x src/tests/labtests ]]; then
        ./src/tests/labtests
    elif [[ -x tests/labtests ]]; then
        ./tests/labtests
    elif [[ -x labtests ]]; then
        ./labtests
    elif [[ -x build/src/labtests ]]; then
        ./build/src/labtests
    elif [[ -x src/labtests ]]; then
        ./src/labtests
    else
        echo "labtests not found."
    fi
}

function bbcmakeall  # run bbcmake in all 'build' folders below current dir
{
    thisdir=$PWD
    find . -name build -a -type d | while read -r dir
    do
        cd $thisdir
        echo
        echo "======== Running bbcmake in $dir ========"
    
        cd $dir
        bbcmake -64 -DCMAKE_BUILD_TYPE=RelWithDebInfo ../src
        echo "================= Done =================="
        echo
        echo
    done
}

function cppcmd  # Give summary of all helper commands
{
    echo
    echo "Summary of C++ shortcut shell commands from found.sh:"
    echo
    echo "(For Foundational C++ Only:)"
    echo "l#:  Change to 'labs' folder for chapter #"
    echo "s#:  Change to lab solutions folder for chapter #"
    echo
    echo "(For All C++ classes:)"
    echo "b:   Change to nearest 'build' dir (below or adjacent to current dir)"
    echo "m:   Change to nearest 'build' directory and run 'make'"
    echo "s:   Change to nearest 'src' directory"
    echo "bb:  Do 'b' and then run a bbcmake command"
    echo "bbm: Do 'bb' and then run a 'make'"
    echo "t:   Change to 'tests' directory"
    echo "bm:  Create build folder (and run bbcmake), and run make"
    echo "labt: Run labtests program in src/tests/labtest"
    echo "i:   Run incrtests in current dir (just a keystroke saver)"
    echo "bbcmakeall:"
    echo "     Run bbcmake in all 'build' folders below current dir"
    echo "cppcmd:"
    echo "     show summary of all these commands"
    echo
}

#echo "cppcmd.sh helper commands installed. Use 'cppcmd' for help summary."

#
# ----------------------- End of cppcmd.sh helpers ---------------------
#
