class Papercut < Formula
  desc "Convert source code files to PDF with configurable formatting"
  homepage "https://github.com/chrislupp/Papercut"
  url "https://github.com/chrislupp/Papercut/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "de1cec0bb352b377430f0dce18c8cc31cb755de9dc6c992a363b0de6da8d48ef"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "papercut #{version}", shell_output("#{bin}/papercut --version")
  end
end
