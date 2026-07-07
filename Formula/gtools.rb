class Gtools < Formula
  desc "Personal custom git subcommands: sweep, sync, pr, done"
  homepage "https://github.com/alexrao2000/git-tools"
  url "https://github.com/alexrao2000/git-tools/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "f312b4cf457232b3bd78692edc9b883121ac9e433dba0ae956a4db8124cd5d0c"
  version "0.4.0"

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
