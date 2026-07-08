class Ezenv < Formula
  desc "Opt-in shell env helpers: per-repo venv auto-activation and python/pip fallback"
  homepage "https://github.com/raocow/ezenv"
  url "https://github.com/raocow/ezenv/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "ad73516697a7f4caa46d6c8d9c15959c8141828a92d7b77230cd6bab55f75d14"
  license "MIT"
  head "https://github.com/raocow/ezenv.git", branch: "master"

  def install
    bin.install "bin/ezenv"
    (share/"ezenv").install Dir["share/ezenv/*.zsh"]
    man1.install "man/ezenv.1"
  end

  def caveats
    <<~EOS
      ezenv features are opt-in. Enable the ones you want, then restart your shell:

        ezenv enable autovenv        # per-repo .venv auto-activation
        ezenv enable pyf             # bare python/pip -> python3/pip3
        ezenv enable                 # everything
        exec zsh

      `ezenv status` shows what's enabled; `ezenv disable <feature>` turns one off.
    EOS
  end

  test do
    assert_match "ezenv", shell_output("#{bin}/ezenv --help")
    assert_match "autovenv.zsh", shell_output("#{bin}/ezenv init autovenv")
    assert_path_exists share/"ezenv/autovenv.zsh"
  end
end
