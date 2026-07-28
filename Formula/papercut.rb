class Papercut < Formula
  desc "Convert source code files to PDF with configurable formatting"
  homepage "https://github.com/chrislupp/Papercut"
  url "https://github.com/chrislupp/Papercut/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "983037ebc18890e7ed606871d5ea080c15ccb38a43f4a71e2c0d92874f52bfe6"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "papercut #{version}", shell_output("#{bin}/papercut --version")
  end
end
