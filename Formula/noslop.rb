class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.104/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "be57b1483458480c05664fe9c08dd56dfb2c322cc6c708123348308dbf411948"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.104/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "87ebde550ddd16b7171ac1627e26942971f7af3c77dd4c701de694d9d5f5ba06"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.104/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8dbf2f613bd07693f4c6460698e8880e17dd6c58ec83e91642bd722ffee61c6c"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.104/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "776b7b94ae96dc565a24a740cf1a6b16f89574fd738d841ddfa180396aea72e5"
    end
  end

  def install
    bin.install "noslop"
    # LICENSE は Homebrew が自動で入れる。同梱の辞書と文法の表示は名前が決まった形でないので明示する
    prefix.install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/noslop --version")
    (testpath/"draft.md").write "まとめると、この方針が大切だと言えるでしょう。\n"
    output = shell_output("#{bin}/noslop check --no-config --format json draft.md")
    assert_match(/"ruleId":\s*"P01"/, output)
  end
end
