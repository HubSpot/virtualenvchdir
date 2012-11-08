####
# Automatically change virtualenvs based upon what directory you are in.
# If the current or parent directory contains a file called .venv with the name of the virtualenv, then
# change into that virtualenv.
####


_venv_is_function_defined() {
    FUNCTION_NAME="$1"
    if [ -n "$ZSH_VERSION" ]; then
        functions | egrep -q "^$FUNCTION_NAME \(\)"
        return $?
    else
        typeset -F | egrep -q "^declare -f $FUNCTION_NAME"
        return $?
    fi
}


_venv_quick_workon() {
    # Only run workon if the new virtualenv is different from this one.
    VIRTUALENV="$1"
    if [[ -z "$VIRTUAL_ENV" ]]; then
        workon $VIRTUALENV
        export _VIRTUALENV_AUTO_SET=1
    elif [[ $VIRTUALENV != $(basename $VIRTUAL_ENV) ]]; then
        workon $VIRTUALENV
        export _VIRTUALENV_AUTO_SET=1
    fi
}


_venv_change_virtualenv() {
    CURRENT_DIR=$(pwd)
    while :; do
        FILE="$CURRENT_DIR"/.venv
        if [[ -e "$FILE" ]]; then
            _venv_quick_workon $(cat "$FILE")
            return
        fi
        if [[ $CURRENT_DIR = "/" ]]; then
            break
        fi
        CURRENT_DIR=$(dirname "$CURRENT_DIR")
    done

    if _venv_is_function_defined "deactivate"; then
        if [[ -n "$_VIRTUALENV_AUTO_SET" ]]; then
            deactivate
            unset _VIRTUALENV_AUTO_SET
        fi
    fi
}


_venv_cd () {
    builtin cd "$@" && _venv_change_virtualenv
}


if _venv_is_function_defined "workon"; then
    alias cd="_venv_cd"
else
    echo "Please use the excellent virtualenvwrapper library first!" 1>&2
fi
