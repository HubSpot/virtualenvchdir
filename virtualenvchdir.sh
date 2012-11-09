####
# Automatically change virtualenvs based upon what directory you are in.
# If the current or parent directory contains a file called .venv with the name of the virtualenv, then
# change into that virtualenv.
####


_venv_quick_workon() {
    # Only run workon if the new virtualenv is different from this one.
    VIRTUALENV="$1"
    if [ -z "$VIRTUAL_ENV" ]; then
        workon $VIRTUALENV
        export _VIRTUALENV_AUTO_SET=1
    elif [ $VIRTUALENV != $(basename $VIRTUAL_ENV) ]; then
        workon $VIRTUALENV
        export _VIRTUALENV_AUTO_SET=1
    fi
}


_venv_change_virtualenv() {
    local _current_dir=$(pwd)
    while :; do
        FILE="$_current_dir"/.venv
        if [ -e "$FILE" ]; then
            _venv_quick_workon $(cat "$FILE")
            return
        fi
        if [ $_current_dir = "/" ]; then
            break
        fi
        _current_dir=$(dirname "$_current_dir")
    done

    if [ -n "$_VIRTUALENV_AUTO_SET" ]; then
        deactivate &>/dev/null
        unset _VIRTUALENV_AUTO_SET
    fi
}


_venv_cd () {
    builtin cd "$@" && _venv_change_virtualenv
}


workon &>/dev/null

if [ $? -eq 127 ]; then
    echo "Please use the excellent virtualenvwrapper library first!" 1>&2
else
    alias cd="_venv_cd"
fi
