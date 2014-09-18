require 'formula'

class Qt < Formula
  homepage "http://qt-project.org/"

  stable do
    # Mirror rather than source set as primary because source is very slow.
    url "http://qtmirror.ics.com/pub/qtproject/archive/qt/5.3/5.3.2/single/qt-everywhere-opensource-src-5.3.2.tar.gz"
    mirror "http://download.qt-project.org/official_releases/qt/5.3/5.3.2/single/qt-everywhere-opensource-src-5.3.2.tar.gz"
    sha1 "502dd2db1e9ce349bb8ac48b4edf7f768df1cafe"
  end


  head "git://gitorious.org/qt/qt.git", :branch => '5.3'

  option :universal
  option 'with-qt3support', 'Build with deprecated Qt3Support module support'
  option 'with-docs', 'Build documentation'
  option 'developer', 'Build and link with developer options'

  depends_on "d-bus" => :optional
  depends_on "mysql" => :optional

  def install
    ENV.universal_binary if build.universal?

    # args = ["-prefix", prefix,
    #         "-system-zlib",
    #         "-qt-libtiff", "-qt-libpng", "-qt-libjpeg",
    #         "-confirm-license", "-opensource",
    #         "-nomake", "demos", "-nomake", "examples",
    #         "-cocoa", "-fast", "-release"]

    args = ["-prefix", prefix,
            "-system-zlib",
            "-qt-libtiff", "-qt-libpng", "-qt-libjpeg",
            "-confirm-license", "-opensource",
            "-nomake", "demos", "-nomake", "examples",
            "-fast", "-release"]

    if ENV.compiler == :clang
        args << "-platform"

        # if MacOS.version >= :mavericks
        #   args << "unsupported/macx-clang-libc++"
        # else
        #   args << "unsupported/macx-clang"
        # end
    end

    args << "-plugin-sql-mysql" if build.with? 'mysql'

    if build.with? 'd-bus'
      dbus_opt = Formula["d-bus"].opt_prefix
      args << "-I#{dbus_opt}/lib/dbus-1.0/include"
      args << "-I#{dbus_opt}/include/dbus-1.0"
      args << "-L#{dbus_opt}/lib"
      args << "-ldbus-1"
      args << "-dbus-linked"
    end

    if build.with? 'qt3support'
      args << "-qt3support"
    else
      args << "-no-qt3support"
    end

    args << "-nomake" << "docs" if build.without? 'docs'

    # AR: Not sure what happens with MacOs on LinuxBrew
    # assume build universal
    # if MacOS.prefer_64_bit? or build.universal?
    #   args << '-arch' << 'x86_64'
    # end
    #
    # if !MacOS.prefer_64_bit? or build.universal?
    #   args << '-arch' << 'x86'
    # end

    if build.universal?
        args << '-arch' << 'x86_64'
        args << '-arch' << 'x86'
    end

    args << '-developer-build' if build.include? 'developer'

    system "./configure", *args
    system "make"
    ENV.j1
    system "make install"

    # what are these anyway?
    # (bin+'pixeltool.app').rmtree
    # (bin+'qhelpconverter.app').rmtree
    # remove porting file for non-humans
    (prefix+'q3porting.xml').unlink if build.without? 'qt3support'

    # Some config scripts will only find Qt in a "Frameworks" folder
    frameworks.install_symlink Dir["#{lib}/*.framework"]

    # The pkg-config files installed suggest that headers can be found in the
    # `include` directory. Make this so by creating symlinks from `include` to
    # the Frameworks' Headers folders.
    Pathname.glob("#{lib}/*.framework/Headers") do |path|
      include.install_symlink path => path.parent.basename(".framework")
    end

    Pathname.glob("#{bin}/*.app") { |app| mv app, prefix }
  end

  test do
    system "#{bin}/qmake", '-project'
  end

  def caveats; <<-EOS.undent
    We agreed to the Qt opensource license for you.
    If this is unacceptable you should uninstall.
    EOS
  end
end
