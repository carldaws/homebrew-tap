class Worktape < Formula
  desc "Record your terminal and its windows for devlogs and screencasts"
  homepage "https://github.com/carldaws/worktape"
  url "https://github.com/carldaws/worktape/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "cc1476f20a89f694e6a2b7b259f78230aaa2b3f80b85a6d495cb03af004196c6"
  license "MIT"

  bottle do
    root_url "https://github.com/carldaws/homebrew-tap/releases/download/worktape-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aef10fdc4828471637b05131ab39de9c54e3e09ed6333c0b5c8600e1b7b9e2b9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5295b5ea6f76f81314e72b95b88e118e174f0ef6968a4701d51ce7a23b462af5"
  end

  depends_on xcode: ["26.0", :build]
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
