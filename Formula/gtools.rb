class Gtools < Formula
  desc "Personal custom git subcommands: sweep, sync, pr, done"
  homepage "https://github.com/raocow/gtools"
  url "https://github.com/raocow/gtools/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "5f933b7252ea6c9e3eac5dfd09744ce0844650b471e56458aa02b31642abb216"

  # `git pr` shells out to the GitHub CLI; the other commands don't need it.
  depends_on "gh"

  def install
    bin.install Dir["bin/git-*"]
    man1.install Dir["man/git-*.1"]
  end

  test do
    assert_match "git sweep", shell_output("#{bin}/git-sweep -h")
    assert_match "git done", shell_output("#{bin}/git-done -h")
    assert_path_exists man1/"git-done.1"
  end
end
