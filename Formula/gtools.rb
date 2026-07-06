class Gtools < Formula
  desc "Personal custom git subcommands: sweep, sync, pr, done"
  homepage "https://github.com/alexrao2000/git-tools"
  url "https://github.com/alexrao2000/git-tools/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7887037ec66fde44d505ab72d1aa8db57142614753034eafd808e2e5f9980db3"
  version "0.1.0"

  # `git pr` shells out to the GitHub CLI; the other commands don't need it.
  depends_on "gh"

  def install
    bin.install Dir["bin/git-*"]
  end

  test do
    assert_match "git sweep", shell_output("#{bin}/git-sweep -h")
    assert_match "git done", shell_output("#{bin}/git-done -h")
  end
end
