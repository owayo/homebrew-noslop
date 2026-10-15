class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.110/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "43bf00f9a9dff51c958a48fa47d42b2aac60c1f355e53a88344c5ce274d6bac9"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.110/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "e465568209f88f5b7995261e5bdf1c8bffb5bf0c4af03d0f2df2b0a6b09a9fd0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.110/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e92969da58eeb492ab5fd1fedf817d66e18690930fd15f11cdf045b1327b8f4"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.110/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f6beab7b6d7a064e5a432b077cf0390978d5fb2cf435a933c681c0ee7e602b6c"
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
