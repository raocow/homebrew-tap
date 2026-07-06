class Gtools < Formula
  desc "Personal custom git subcommands: sweep, sync, pr, done"
  homepage "https://github.com/alexrao2000/git-tools"
  url "https://github.com/alexrao2000/git-tools/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "70285c4e374e422fe1ebeae3268015303d9fee81ff2bdccecce955d16924da92"
  version "0.3.0"

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
