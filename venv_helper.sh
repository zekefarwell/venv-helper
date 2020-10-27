# Python VEnv Helper
#
# A helper function for working with the python venv module
# that stores all virtual environments in one directory at ~/venv
# and uses the current working directory name when a venv name is omitted.
#
# Installation:
#
# 1. Copy this file to ~/.venv_helper.sh (or any location you prefer)
#
# 2. Include the file in your ~/.profile, ~/.bash_profile, or ~/.zshrc depending on platform
#    Add this line (change path if you chose a different location)
#
#       [ -f $HOME/.venv_helper.sh ] && . $HOME/.venv_helper.sh
#

# Path where virtual environments live
VENV_HOME="$HOME/venv"

# Default Python 3 interpreter path or command
DEFAULT_PYTHON="python3"

venv() {

    venv-help() {
        echo ""
        echo "Usage:"
        echo "  venv <command> [options] [venv_name]"
        echo ""
        echo "Current directory name is used when venv_name is omitted"
        echo ""
        echo "Commands:"
        echo "  create                 Create virtual environment"
        echo "  delete | remove | rm   Delete virtual environment"
        echo "  list | ls              List all virtual environments"
        echo "  activate | shell       Activate virtual environment"
        echo "  deactivate | exit      Deactivate current virtual environment"
        echo "  help                   Display this help info"
        echo ""
        echo "Options:"
        echo "  -p|--python <interpreter>      Python interpreter to create virtual environment with."
        echo "                                 Should be a valid shell command or absolute path."
        echo ""
        echo "Virtual environment home         $VENV_HOME"
        echo "Default python interpreter       $DEFAULT_PYTHON"
        echo ""
    }

    PYTHON=$DEFAULT_PYTHON

    # Parse optional argument flags
    PARAMS=""
    while (( $# )); do
        case "$1" in
            -p|--python)
                if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                    PYTHON=$2
                    shift 2
                fi
                ;;
            -h|--help)
                PARAMS="$PARAMS help"
                shift
                ;;
            *) # Preserve positional arguments
                PARAMS="$PARAMS $1"
                shift
                ;;
        esac
    done

    # Set positional arguments back in place without optional flags
    eval set -- "$PARAMS"

    # Create virtual environment home directory if it doesn't exist
    [[ -d $VENV_HOME ]] || mkdir $VENV_HOME

    # Set virtual environment name as optional second parameter
    # Use current directory name if omitted
    if [ -z "$2" ]
    then
        venv_name=`basename $PWD`
    else
        venv_name="$2"
    fi

    if ! command -v $PYTHON > /dev/null 2>&1; then
        echo "Python interpreter not found: $PYTHON"
        echo ""
        return
    fi
    python_version=$($PYTHON --version)
    python_path=$(which $PYTHON)

    # Handle sub command (first parameter)
    case "$1" in
        create)
            echo "Creating virtual environment \"$venv_name\" with $python_version ($python_path)"
            $PYTHON -m venv $VENV_HOME/$venv_name
            ;;
        delete|remove|rm)
            echo "Deleting virtual environment \"$venv_name\" from $VENV_HOME"
            sleep 1
            rm -r $VENV_HOME/$venv_name
            ;;
        list|ls)
            echo "Virtual environments in $VENV_HOME:"
            ls -1 $VENV_HOME
            ;;
        activate|shell)
            if [ -f "$VENV_HOME/$venv_name/bin/activate" ]; then
                venv_python_version=$($VENV_HOME/$venv_name/bin/python --version)
                echo "Activating virtual environment \"$venv_name\" with $venv_python_version"
                source "$VENV_HOME/$venv_name/bin/activate"
            else
                echo "Virtual environment  \"$venv_name\" not found in $VENV_HOME"
                echo ""
            fi
            ;;
        deactivate|exit)
            deactivate
            ;;
        help)
            venv-help
            ;;
        *)
            echo "Usage:  venv create|delete|list|shell|help"
            echo ""
    esac

}
