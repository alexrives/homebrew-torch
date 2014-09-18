require "formula"

class LuajitRocks < Formula
  head "https://github.com/torch/luajit-rocks.git", :branch => "master"
  homepage "https://github.com/torch/luajit-rocks"

  # depends_on "cmake" => :build

  def install
    system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system "make install"
  end
end
