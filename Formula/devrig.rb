class Devrig < Formula
  desc "Opt-in dev environment helpers: venv, python/pip fallback, git accounts"
  homepage "https://github.com/raocow/devrig"
  url "https://github.com/raocow/devrig/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "6eed8f7cb3616291635d080f62aa310f6c092333d8a30ea0e1c6c482328e6b79"
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

      New in this release: `devrig account` ties a directory to a separate git/ssh
      account (e.g. work vs personal). See the README for details.
    EOS
  end

  test do
    assert_match "devrig", shell_output("#{bin}/devrig --help")
    assert_match "autovenv.zsh", shell_output("#{bin}/devrig init autovenv")
    assert_path_exists share/"devrig/autovenv.zsh"
  end
end
