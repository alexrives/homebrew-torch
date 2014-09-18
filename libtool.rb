require 'formula'


class Libtool < Formula
  homepage 'http://www.gnu.org/software/libtool/'
  url 'http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/libtool/libtool-2.4.2.tar.gz'
  sha1 '22b71a8b5ce3ad86e1094e7285981cae10e6ff88'

  option :universal

  # Allow -stdlib= to pass through to linker
  # http://git.savannah.gnu.org/gitweb/?p=libtool.git;a=commitdiff;h=8f975a1368594126e37d85511f1f96164e466d93
  # https://trac.macports.org/ticket/32982
  patch :DATA

  def install
    ENV.universal_binary if build.universal?
    # system "./configure", "--disable-dependency-tracking",
    #                       "--prefix=#{prefix}",
    #                       "--program-prefix=g",
    #                       "--enable-ltdl-install"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-ltdl-install"
    system "make install"
  end

  test do
    system "#{bin}/glibtool", 'execute', '/usr/bin/true'
  end
end
