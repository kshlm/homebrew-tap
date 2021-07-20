class TeleportAT4 < Formula
  desc "Modern SSH server for teams managing distributed infrastructure"
  homepage "https://gravitational.com/teleport"
  url "https://github.com/gravitational/teleport/archive/v4.4.10.tar.gz"
  sha256 "6a9ba49433e3a8c2bad69c06376fe27e224ffcbead7773713b5449ac07deb828"
  license "Apache-2.0"
  head "https://github.com/gravitational/teleport.git"

  livecheck do
    url "https://github.com/gravitational/teleport/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  depends_on "go" => :build

  uses_from_macos "curl" => :test
  uses_from_macos "zip"

  on_linux do
    depends_on "netcat" => :test
  end

  resource "webassets" do
    url "https://github.com/gravitational/webassets/archive/72412062d6d55ec7faa9707abf500d703e7d09da.tar.gz"
    sha256 "c84767bea0a723f406e3b6566a0a48892758b2e5f3a9e9b453d22171315fd29d"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOROOT"] = Formula["go"].opt_libexec

    (buildpath/"webassets").install resource("webassets")
    (buildpath/"src/github.com/gravitational/teleport").install buildpath.children
    cd "src/github.com/gravitational/teleport" do
      ENV.deparallelize { system "make", "full" }
      bin.install "build/tsh" => "tsh4", "build/teleport" => "teleport4", "build/tctl" => "tctl4"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/teleport version")
    (testpath/"config.yml").write shell_output("#{bin}/teleport configure")
      .gsub("0.0.0.0", "127.0.0.1")
      .gsub("/var/lib/teleport", testpath)
      .gsub("/var/run", testpath)
      .gsub(/https_(.*)/, "")
    begin
      pid = spawn("#{bin}/teleport start -c #{testpath}/config.yml")
      sleep 5
      system "/usr/bin/curl", "--insecure", "https://localhost:3080"
      system "/usr/bin/nc", "-z", "localhost", "3022"
      system "/usr/bin/nc", "-z", "localhost", "3023"
      system "/usr/bin/nc", "-z", "localhost", "3025"
    ensure
      Process.kill(9, pid)
    end
  end
end
