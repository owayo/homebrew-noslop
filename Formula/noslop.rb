class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.101/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "1c4a357012eb224ac376359c537b2ce33e80e8dd17418a2b3b2150eb2aed45ae"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.101/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "516dcc4dd5ad22589a2cc4791f5b5070a502eacdd5f37c4c88c3cd01d8ba6e9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.101/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "89dcff9177f46b94f02dca2170ca559c9b8d760d77347a2f03c1b3ca8a25bfcb"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.101/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bf5e7a81c34c6036af5ab01561b3e9feb2190432c77ec22e124c54197237c61c"
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
