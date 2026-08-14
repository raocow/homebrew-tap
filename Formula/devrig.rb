class Devrig < Formula
  desc "Opt-in shell environment helpers: venv, python/pip fallback, dotenv, sleep"
  homepage "https://github.com/raocow/devrig"
  url "https://github.com/raocow/devrig/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "22ae1c77d1407a0c3685d53fe39b96859cce911235954a99d5178634238a9f1a"
  license "MIT"
  head "https://github.com/raocow/devrig.git", branch: "master"

  def install
    bin.install "bin/devrig"
    (share/"devrig").install Dir["share/devrig/*.zsh"]
    man1.install "man/devrig.1"
  end

  def caveats
    <<~EOS
      devrig features are opt-in. Enable the ones you want, then restart your shell:

        devrig enable autovenv        # per-repo .venv auto-activation
        devrig enable pyf             # bare python/pip -> python3/pip3
        devrig enable                 # everything
        exec zsh

      `devrig status` shows what's enabled; `devrig disable <feature>` turns one off.

      `devrig account` ties a directory to a separate git/ssh account (e.g. work
      vs personal). New in this release: `account add --gh-user <username>` also
      pairs it with a `gh` CLI login, and `devrig enable ghswitch` keeps gh's
      active account correct automatically as you cd between them — gh's active
      account is shared by every terminal on the machine, so anything else using
      a different identity anywhere can silently flip it back otherwise. See the
      README for details.
    EOS
  end

  test do
    assert_match "devrig", shell_output("#{bin}/devrig --help")
    assert_match "autovenv.zsh", shell_output("#{bin}/devrig init autovenv")
    assert_path_exists share/"devrig/autovenv.zsh"
  end
end
