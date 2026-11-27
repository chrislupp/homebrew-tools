class Scirocco < Formula
  desc "Airfoil panel code with adjoint gradients for design optimization"
  homepage "https://github.com/chrislupp/Scirocco"
  url "https://github.com/chrislupp/Scirocco/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "f51232f1c66a4f5be66516b0a18e08a62813d6c0be17e5254e129b21b6347a66"
  license "Apache-2.0"
  head "https://github.com/chrislupp/Scirocco.git", branch: "develop"

  depends_on "cmake" => [:build, :test]
  depends_on "eigen"

  on_linux do
    depends_on "openblas"
  end

  def install
    # The CMake project lives in scirocco/. Turn off -march=native so the
    # library runs on any machine, and skip the tests and examples.
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DSCIROCCO_NATIVE_ARCH=OFF
      -DSCIROCCO_BUILD_TESTS=OFF
      -DSCIROCCO_BUILD_EXAMPLES=OFF
    ]
    system "cmake", "-S", "scirocco", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 3.18)
      project(consumer LANGUAGES CXX)
      find_package(scirocco #{version} EXACT CONFIG REQUIRED)
      add_executable(consumer main.cpp)
      target_link_libraries(consumer PRIVATE scirocco::scirocco)
    CMAKE

    (testpath/"main.cpp").write <<~CPP
      #include <scirocco/scirocco.h>

      #include <cmath>
      #include <iostream>

      int main() {
          scirocco::Scirocco foil("0012", 60);
          foil.SetOper(4.0);
          if (!foil.Solve() || !std::isfinite(foil.GetCl())) return 1;
          std::cout << "Cl = " << foil.GetCl() << std::endl;
          return foil.GetCl() > 0.4 ? 0 : 1;
      }
    CPP

    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_PREFIX_PATH=#{opt_prefix}"
    system "cmake", "--build", "build"
    assert_match "Cl = ", shell_output("./build/consumer")
  end
end
