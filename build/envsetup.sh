function __print_standartos_functions_help() {
cat <<EOF
Additional StandartOS functions:
- cout:                    Changes directory to out.
- standartosremote:        Add git remote for StandartOS Gerrit Review.
- repodiff:                Diff 2 different branches or tags within the same repo
- repolastsync:            Prints date and time of last repo sync.
- repopick:                Utility to fetch changes from Gerrit.
- sort-blobs-list:         Sort proprietary-files.txt sections with LC_ALL=C.
EOF
}

function cout()
{
    if [  "$OUT" ]; then
        cd $OUT
    else
        echo "Couldn't locate out directory.  Try setting OUT."
    fi
}

function githubremote()
{
    if ! git rev-parse --git-dir &> /dev/null
    then
        echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
        return 1
    fi
    git remote rm github 2> /dev/null
    local REMOTE=$(git config --get remote.aosp.projectname)

    if [ -z "$REMOTE" ]
    then
        REMOTE=$(git config --get remote.clo.projectname)
    fi

    local PROJECT=$(echo $REMOTE | sed -e "s#platform/#android/#g; s#/#_#g")

    git remote add github https://github.com/StandartOS/$PROJECT
    echo "Remote 'github' created"
}

function repodiff() {
    if [ -z "$*" ]; then
        echo "Usage: repodiff <ref-from> [[ref-to] [--numstat]]"
        return
    fi
    diffopts=$* repo forall -c \
      'echo "$REPO_PATH ($REPO_REMOTE)"; git diff ${diffopts} 2>/dev/null ;'
}

function repolastsync() {
    RLSPATH="$ANDROID_BUILD_TOP/.repo/.repo_fetchtimes.json"
    RLSLOCAL=$(date -d "$(stat -c %z $RLSPATH)" +"%e %b %Y, %T %Z")
    RLSUTC=$(date -d "$(stat -c %z $RLSPATH)" -u +"%e %b %Y, %T %Z")
    echo "Last repo sync: $RLSLOCAL / $RLSUTC"
}

function repopick() {
    T=$(gettop)
    $T/vendor/standart/build/tools/repopick.py $@
}

function sort-blobs-list() {
    T=$(gettop)
    $T/tools/extract-utils/sort-blobs-list.py $@
}

# Override host metadata to make builds more reproducible and avoid leaking info
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=android-build
