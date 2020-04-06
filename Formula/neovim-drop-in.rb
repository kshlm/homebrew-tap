class NeovimDropIn < Formula
  desc "Emulate vim and vi executables with neovim"
  homepage "https://aur.archlinux.org/packages/neovim-drop-in/"
  url "https://aur.archlinux.org/cgit/aur.git/snapshot/neovim-drop-in.tar.gz"
  version "1.0"
  sha256 "13fe3a08257a3aa1cd310aad524e510fae2d9f1dce3812476e2881318c40f4fb"

  depends_on "neovim"

  conflicts_with "ex-vi",
    :because => "neovim-drop-in and ex-vi both install bin/ex and bin/view"

  conflicts_with "macvim",
    :because => "neovim-drop-in and macvim both install vi* binaries"

  conflicts_with "vim",
    :because => "neovim-drop-in and vim both install vi* binaries"

  def install
    bin.mkpath
    bin.install "ex.sh" => "ex"
    bin.install "exim.sh" => "exim"
    bin.install "rview.sh" => "rview"
    bin.install "rvim.sh" => "rvim"
    bin.install "view.sh" => "view"
    bin.install "vimdiff.sh" => "vimdiff"
    bin.install_symlink "/usr/local/bin/nvim" => "vim"
    bin.install_symlink "/usr/local/bin/nvim" => "vi"
  end
end
