class NeovimNightlyBin < Formula
  desc "Neovim - Nightly builds from upstream"
  homepage "https://neovim.io"
  version "nightly"

  on_arm do
    url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"
  end
  on_intel do
    url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz"
  end

  conflicts_with "neovim",
    because: "neovim-nightly and neovim both install bin/nvim"

  def install
    bin.mkpath
    bin.install "bin/nvim" => "nvim"
    prefix.install Dir["lib"]
    prefix.install Dir["share"]
  end
end
