homebrew-torch
==============

A set of homebrew formulas to install the torch7 dependencies
on the digs with [linuxbrew](https://github.com/Homebrew/linuxbrew).

To install linuxbrew:

    $ git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew"

    # Add the following to ~/.bash_profile

    $ emacs ~/.bash_profile

    export PATH=\"$HOME/.linuxbrew/bin:$PATH"
    export LD_LIBRARY_PATH=\"$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH\"
    export C_INCLUDE_PATH=\"$HOME/.linuxbrew/include:$C_INCLUDE_PATH\"

To install torch7 and dependencies:

    curl -s https://raw.githubusercontent.com/alexrives/torch-install/master/install-deps | bash
    curl -s https://raw.githubusercontent.com/alexrives/torch-install/master/install-luajit+torch | bash
