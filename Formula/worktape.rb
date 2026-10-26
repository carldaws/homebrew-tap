class Worktape < Formula
  desc "Record your terminal and its windows for devlogs and screencasts"
  homepage "https://github.com/carldaws/worktape"
  url "https://github.com/carldaws/worktape/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "cc1476f20a89f694e6a2b7b259f78230aaa2b3f80b85a6d495cb03af004196c6"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on "asciinema"
  depends_on macos: :sequoia

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/worktape"
  end

  test do
    assert_match "usage: worktape", shell_output("#{bin}/worktape --help")
    system bin/"worktape", "init"
    assert_path_exists testpath/".worktapes/.gitignore"
  end
end
