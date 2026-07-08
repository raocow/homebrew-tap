class Ezenv < Formula
  desc "Opt-in shell env helpers: per-repo venv auto-activation and python/pip fallback"
  homepage "https://github.com/raocow/ezenv"
  url "https://github.com/raocow/ezenv/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "5c62ceb6a8b97bf0510aa668ac296c035e32e9f71a8875715657b9ab8d2733a1"
  license "MIT"
  head "https://github.com/raocow/ezenv.git", branch: "master"

  def install
    bin.install "bin/ezenv"
    (share/"ezenv").install Dir["share/ezenv/*.zsh"]
    man1.install "man/ezenv.1"
  end

  def caveats
    <<~EOS
      ezenv features are opt-in. Add the lines you want to your ~/.zshrc:

        source "#{opt_share}/ezenv/autovenv.zsh"     # per-repo .venv auto-activation
        source "#{opt_share}/ezenv/py-fallback.zsh"  # bare python/pip -> python3/pip3

      Or enable everything:

        source "#{opt_share}/ezenv/ezenv.zsh"

      Run `ezenv init` to print these, or `ezenv doctor` to check status.
    EOS
  end

  test do
    assert_match "ezenv", shell_output("#{bin}/ezenv --help")
    assert_match "autovenv.zsh", shell_output("#{bin}/ezenv init autovenv")
    assert_path_exists share/"ezenv/autovenv.zsh"
  end
end
