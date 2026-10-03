class Rigor < Formula
  desc "Opt-in shell environment helpers: venv, python/pip fallback, dotenv, sleep, push"
  homepage "https://github.com/raocow/rigor"
  url "https://github.com/raocow/rigor/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "b7fc761d928c58d7ce220380c48014efce9f15bab519b001961de9624519958f"
  license "MIT"
  head "https://github.com/raocow/rigor.git", branch: "master"

  deprecate! date: "2026-10-02", because: "has been merged into gowork: brew install raocow/tap/gowork"
  conflicts_with "gowork", because: "gowork includes rigor"

  def install
    bin.install "bin/rigor"
    (share/"rigor").install Dir["share/rigor/*.zsh"]
    (share/"rigor/push").install Dir["share/rigor/push/*"]
    man1.install "man/rigor.1"
  end

  def caveats
    <<~EOS
      rigor features are opt-in. Enable the ones you want, then restart your shell:

        rigor enable autovenv        # per-repo .venv auto-activation
        rigor enable pyf             # bare python/pip -> python3/pip3
        rigor enable                 # everything
        exec zsh

      `rigor status` shows what's enabled; `rigor disable <feature>` turns one off.

      Per-directory git/ssh/GitHub accounts moved to gitplus — see `gp account`.

      Notify your phone when a Claude Code or Codex turn ends: `rigor push setup`.
    EOS
  end

  test do
    assert_match "rigor", shell_output("#{bin}/rigor --help")
    assert_match "autovenv.zsh", shell_output("#{bin}/rigor init autovenv")
    assert_path_exists share/"rigor/autovenv.zsh"
  end
end
