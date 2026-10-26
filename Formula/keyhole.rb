class Keyhole < Formula
  desc "Serve 1Password secrets on a Unix socket, for VMs on your Mac"
  homepage "https://github.com/carldaws/keyhole"
  url "https://github.com/carldaws/keyhole/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a81fb01ec940b4f3cf13f8d4018a0994b39cf136fbab5d2d4d84525c69b3f21b"
  license "MIT"
  head "https://github.com/carldaws/keyhole.git", branch: "main"

  bottle do
    root_url "https://github.com/carldaws/homebrew-tap/releases/download/keyhole-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e608cb799924856fd40811e3a3bb1b9585e848cd75e495c4abf48c6e8c12765e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "66e5106e8a5ecff02368dec8fe0e723ae1573edf0aab004fc6fac1acf4a2b696"
  end

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/keyhole version").strip
    assert_match "-account is required", shell_output("#{bin}/keyhole serve 2>&1", 2)
  end
end
