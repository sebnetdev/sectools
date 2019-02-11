

if [[ $(uname) == "Darwin" ]]
then
    GREP=ggrep
else
    GREP=grep
fi

Info()
{
    local msg="$1"
    echo "$msg" 1>&2
}

join_str()
{
    BACKIFS="$IFS"
    IFS="$1"
    shift
    echo "$@";
    IFS="$BACKIFS"
}
