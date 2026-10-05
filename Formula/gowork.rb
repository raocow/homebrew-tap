class Gowork < Formula
  desc "Git + GitHub PR workflow, per-directory identity, and dev-shell setup (gw)"
  homepage "https://github.com/raocow/gowork"
  url "https://github.com/raocow/gowork/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "4b819afd8eb0904c5996c6e273b985fddac7c92cecb5cc4bc913690373e51725"
  license "MIT"
  head "https://github.com/raocow/gowork.git", branch: "main"

  # gw pr and gw account talk to GitHub through the GitHub CLI.
  depends_on "gh"

  # gowork is both of these, merged; all three install gp and rigor.
  conflicts_with "rigor", because: "gowork includes rigor"
  conflicts_with "gitplus", because: "gowork includes gitplus"

  def install
    bin.install Dir["bin/*"]                        # gowork, gw, gp, gp-*, rigor
    lib.install "lib/gitplus-common.sh"             # sourced by gp-* from ../lib
    libexec.install Dir["libexec/*"]                # gw migrate, gw browser
    (share/"rigor").install Dir["share/rigor/*"]    # shell features, push, identity
    zsh_completion.install Dir["share/zsh/site-functions/*"]
    man1.install Dir["man/*.1"]
  end

  def caveats
    <<~EOS
      Coming from rigor or gitplus? Point your setup at gowork, then remove them:

        gw migrate --dry-run     # see what changes
        gw migrate
        brew uninstall rigor gitplus

      New here:

        gw help
        gw account setup         # per-directory GitHub/AWS identity, agents included
        gw shell enable          # autovenv, pyf, envup (then: exec zsh)
        gw browser setup         # links open in the browser signed in to the right account
    EOS
  end

  test do
    assert_match "gowork (gw)", shell_output("#{bin}/gw help")
    assert_match "gp sweep", shell_output("#{bin}/gp-sweep -h")
    assert_match "autovenv.zsh", shell_output("#{bin}/rigor init autovenv")
    assert_path_exists share/"rigor/identity/gh"
  end
end
