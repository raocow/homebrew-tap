class Gitplus < Formula
  desc "Personal custom git subcommands: sweep, sync, pr, done"
  homepage "https://github.com/raocow/gitplus"
  url "https://github.com/raocow/gitplus/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "926eef145bf8061a04098f846d63ada1531977cc2a992307edb86a0aef64f682"

  # `git pr` shells out to the GitHub CLI; the other commands don't need it.
  depends_on "gh"

  def install
    bin.install Dir["bin/git-*"]
    man1.install Dir["man/git-*.1"]
    lib.install "lib/gitplus-common.sh" if File.exist?("lib/gitplus-common.sh")
    zsh_completion.install Dir["share/zsh/site-functions/*"] if
      Dir.exist?("share/zsh/site-functions")
  end

  def caveats
    <<~EOS
      For Tab-completion — including 'git new <TAB>' for short branch names and
      'git pr list <TAB>' — add this to ~/.zshrc. Homebrew's own site-functions
      dir (where these completions live) is already on fpath via `brew
      shellenv`, BUT the git formula also ships its own _git there, and it does
      NOT support the git-<subcommand> dispatch these completions rely on — so
      with it in front, 'git pr list <TAB>' / 'git new <TAB>' fall through to
      plain file completion. Putting zsh's own function dirs first makes zsh's
      _git (which does support it) win, while keeping Homebrew's dir on fpath:

        typeset -U fpath
        fpath=(/usr/share/zsh/${ZSH_VERSION}/functions /usr/share/zsh/site-functions $fpath)
        autoload -Uz compinit && compinit
    EOS
  end

  test do
    assert_match "git sweep", shell_output("#{bin}/git-sweep -h")
    assert_match "git done", shell_output("#{bin}/git-done -h")
    assert_path_exists man1/"git-done.1"
  end
end
