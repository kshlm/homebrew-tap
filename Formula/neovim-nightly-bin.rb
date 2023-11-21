class NeovimNightlyBin < Formula
  desc "Neovim - Nightly builds from upstream"
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz"
  version "nightly"

  conflicts_with "neovim",
    because: "neovim-nightly and neovim both install bin/nvim"

  def install
    bin.mkpath
    bin.install "bin/nvim" => "nvim"
    prefix.install Dir["lib"]
    prefix.install Dir["share"]
  end
end
