class Gitplus < Formula
  desc "Personal git tooling under the gp command: sweep, sync, pr, done"
  homepage "https://github.com/raocow/gitplus"
  url "https://github.com/raocow/gitplus/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "71f733bf2c33c287b05fe167e8e6f9f1edb350f1b5064fc7d10f1bc56b6809fd"

  # `gp pr` shells out to the GitHub CLI; the other commands don't need it.
  depends_on "gh"

  def install
    bin.install "bin/gp"
    bin.install Dir["bin/gp-*"]
    man1.install Dir["man/gp-*.1"]
    lib.install "lib/gitplus-common.sh" if File.exist?("lib/gitplus-common.sh")
    zsh_completion.install Dir["share/zsh/site-functions/*"] if
      Dir.exist?("share/zsh/site-functions")
    (share/"gitplus").install "share/zsh/ghswitch.zsh" if File.exist?("share/zsh/ghswitch.zsh")
  end

  def caveats
    <<~EOS
      Tab-completion for `gp <TAB>` and `gp pr list <TAB>` etc. works via
      Homebrew's site-functions directory (already on fpath via `brew shellenv`).
      Make sure compinit runs after fpath is set:

        autoload -Uz compinit && compinit

      Optional: keep gh's identity matched to whichever directory your shell
      is in, per shell, instead of gh's machine-wide active account (which any
      other terminal or agent can change under you):

        source "#{opt_share}/gitplus/ghswitch.zsh"

      The gp commands resolve the right account themselves either way —
      this only affects bare 'gh' commands you type by hand.
    EOS
  end

  test do
    assert_match "gp sweep", shell_output("#{bin}/gp-sweep -h")
    assert_match "gp done", shell_output("#{bin}/gp-done -h")
    assert_path_exists man1/"gp-done.1"
  end
end
