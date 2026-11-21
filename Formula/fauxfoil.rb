class Fauxfoil < Formula
  desc "XFOIL-style command-line program and plot window built on Scirocco"
  homepage "https://github.com/chrislupp/Scirocco"
  # Built from Scirocco's release source; its release workflow keeps this
  # url and sha256 the same as in scirocco.rb.
  url "https://github.com/chrislupp/Scirocco/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "2aec4bb3fd0b4f22032f6f6c2a3a92f8151e76e8ba189d902077536286966069"
  license "Apache-2.0"
  head "https://github.com/chrislupp/Scirocco.git", branch: "develop"

  depends_on "cmake" => :build
  depends_on "chrislupp/tools/scirocco"
  depends_on "qtbase"

  def install
    # The CMake project lives in fauxfoil/. An empty FAUXFOIL_SCIROCCO_SOURCE
    # builds against the installed scirocco formula instead of the bundled
    # source tree.
    args = %w[
      -DFAUXFOIL_SCIROCCO_SOURCE=
      -DFAUXFOIL_GRAPHICS=ON
      -DFAUXFOIL_BUILD_TESTS=OFF
    ]
    system "cmake", "-S", "fauxfoil", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    ENV["FAUXFOIL_NOGRAPHICS"] = "1"
    banner = pipe_output(bin/"fauXFOIL", "", 0)
    assert_match "fauXFOIL Version #{version}\n", banner
    refute_match "built without its plot window", banner

    session = pipe_output(bin/"fauXFOIL", "NACA 0012\nOPER\nALFA 4\n\nQUIT\n", 0)
    assert_match(/CL\s*=\s*0\.4/, session)
  end
end
