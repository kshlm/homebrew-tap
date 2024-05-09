class NeovimBin < Formula
  desc "Neovim - Builds from upstream"
  homepage "https://neovim.io"
  version "0.9.5"
  url "https://github.com/neovim/neovim/releases/download/v#{version}/nvim-macos.tar.gz"

  on_arm do
    head "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"
  end
  on_intel do
    head "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz"
  end

  conflicts_with "neovim",
    because: "neovim-bin and neovim both install bin/nvim"

  conflicts_with "neovim-nightly-bin",
    because: "neovim-bin and neovim-nightly-bin both install bin/nvim"


  def install
    bin.mkpath
    bin.install "bin/nvim" => "nvim"
    prefix.install Dir["lib"]
    prefix.install Dir["share"]
  end
end
