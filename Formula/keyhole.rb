class Keyhole < Formula
  desc "Serve 1Password secrets on a Unix socket, for VMs on your Mac"
  homepage "https://github.com/carldaws/keyhole"
  url "https://github.com/carldaws/keyhole/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a81fb01ec940b4f3cf13f8d4018a0994b39cf136fbab5d2d4d84525c69b3f21b"
  license "MIT"
  head "https://github.com/carldaws/keyhole.git", branch: "main"

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
