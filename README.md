homebrew-torch
==============

    # imagemagick dependencies:
    xz, libtool, libpng, freetype

    brew link libtool --force
    brew link libpng --force
    brew link freetype --force

    # the following only works after linking as above, edit the formulas appropriately
    brew install imagemagick

    # we already have gnuplot so try skipping that for now

    # need to unlink readline
    brew unlink readline

    # need to setup:
    C_INCLUDE_PATH="$HOME/.linuxbrew/include:$C_INCLUDE_PATH"

    # then run

    git clone https://github.com/torch/luajit-rocks.git
    cd luajit-rocks
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=/work/arives/local

    make install


    curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-luajit+torch | bash





    # libtool

    In order to prevent conflicts with Apple's own libtool we have prepended a "g"
    so, you have instead: glibtool and glibtoolize.

    This formula is keg-only, which means it was not symlinked into /gpfs/DS3524-1/WORK/arives/.linuxbrew.

    Xcode provides this software prior to version 4.3.

    Generally there are no consequences of this for you. If you build your
    own software and it requires this formula, you'll need to add to your
    build variables:

    LDFLAGS:  -L/gpfs/DS3524-1/WORK/arives/.linuxbrew/opt/libtool/lib
    CPPFLAGS: -I/gpfs/DS3524-1/WORK/arives/.linuxbrew/opt/libtool/include

    # libpng

    This formula is keg-only, which means it was not symlinked into /gpfs/DS3524-1/WORK/arives/.linuxbrew.

    Mac OS X already provides this software in versions before Mountain Lion.

    Generally there are no consequences of this for you. If you build your
    own software and it requires this formula, you'll need to add to your
    build variables:

    LDFLAGS:  -L/gpfs/DS3524-1/WORK/arives/.linuxbrew/opt/libpng/lib
    CPPFLAGS: -I/gpfs/DS3524-1/WORK/arives/.linuxbrew/opt/libpng/include

    # freetype

    This formula is keg-only, which means it was not symlinked into /gpfs/DS3524-1/WORK/arives/.linuxbrew.

    Mac OS X already provides this software in versions before Mountain Lion.

    Generally there are no consequences of this for you. If you build your
    own software and it requires this formula, you'll need to add to your
    build variables:

    LDFLAGS:  -L/gpfs/DS3524-1/WORK/arives/.linuxbrew/opt/freetype/lib
    CPPFLAGS: -I/gpfs/DS3524-1/WORK/arives/.linuxbrew/opt/freetype/include
