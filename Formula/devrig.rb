class Devrig < Formula
  desc "Opt-in dev environment helpers: venv, python/pip fallback, git accounts"
  homepage "https://github.com/raocow/devrig"
  url "https://github.com/raocow/devrig/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "46e1035d91754e066151cf56b972c43c0e0ad49b0526c2ceed5ab0546eefc9b5"
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
