# VEnv Helper

[The venv module](https://docs.python.org/3/library/venv.html) included with Python since v3.3
supports creating virtual evironments without needing a separate tool.  However activating and
managing these virtual environments can be a bit tedious, especially if you store them in a
central location.  This script aims to
ease that frustration.

## Installation

1. Copy `venv_helper.sh` to `~/.venv_helper.sh` (or any location you prefer).
2. Add this line to your  `~/.bash_profile`, `~/.profile`, or `~/.zshrc` (depending on shell or platform)
   to include the script.

    ```sh
     -f $HOME/.venv_helper.sh ] && . $HOME/.venv_helper.sh
    ```

    > :warning: *If you chose a custom location, change the include path.*

3. Open a new terminal or source your `~/.profile`, `~/.bash_profile`, or `~/.zshrc` to activate
   the `venv` command.

    ```sh
    $ source ~/.bash_profile|~/.profile|~/.zshrc
    ```

## Usage

### Specifying A Name

Create, activate, and then delete a virtual environment named *larry*:

```sh
$ venv create larry
Creating virtual environment "larry" with Python 3.8.6 (/usr/local/bin/python3.8)
```

```sh
$ venv activate larry
Activating virtual environment "larry" with Python 3.8.6
```

```sh
$ venv delete larry
Deleting virtual environment "larry" from /Users/zeke/venv
```

### Using Project Directory Name

The virtual environment name can also be ommitted, and the current working directory
name will be used instead.  This is a nice convenience when you want the virtual
environment name and project name to match.

Create, activate, and then delete a virtual environment for a project named *curly*:

```sh
$ mkdir curly
$ cd curly
```

```sh
$ venv create
Creating virtual environment "curly" with Python 3.8.6 (/usr/local/bin/python3.8)
```

```sh
$ venv activate
Activating virtual environment "curly" with Python 3.8.6
```

```sh
$ venv delete
Deleting virtual environment "curly" from /Users/zeke/venv
```

### Specifying A Python Version

The version of python to use can be specified with the optional `-p` or `--python` flag.
This flag takes an argument of a valid shell command or an absolute path to an interpreter.

Create a virtual environment named *moe* with python 3.9:

```sh
$ venv create -p python3.9 moe
Creating virtual environment "moe" with Python 3.9.0 (/usr/local/opt/python@3.9/bin/python3.9)
```

Same thing but in long form:

```sh
$ venv create moe --python /usr/local/opt/python@3.9/bin/python3.9
Creating virtual environment "moe" with Python 3.9.0 (/usr/local/opt/python@3.9/bin/python3.9)
```

### Listing Virtual Environments

Sometimes you want to see all the virtual environments you've created.

```sh
$ venv list
Virtual environments in /Users/zeke/venv:
larry
curly
moe
```

### Shortcuts / Alternate Syntax

Some commands have alternate syntax because why not.

- `venv delete` == `venv remove` == `venv rm`
- `venv list` == `venv ls`
- `venv activate` == `venv shell`
- `deactivate` == `venv deactivate` == `venv exit`

## Configuration

There are several global variables at the top of the script that can be changed to suit your
needs.

### VENV_HOME

This is the path were virtual environments are stored.  Defaults to `~/venv`.
Changing this variable will not move existing virtual environments to the new location.

### DEFAULT_PYTHON

The default python shell command to use when the `-p` or `--python` flag is not specified.
You'll want to change this if the `python3` command isn't present on your system or
isn't the default version of python you want to use to create virtual environments.
This variable can be a shell command like `python3.9` or an absolute path to the
interpreter like `/usr/local/bin/python3.9`.
