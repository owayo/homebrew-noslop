class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.11.102/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "6507daeca96b6dc4e4897145aa8b9699105c36eeb938f5c27bcc677e824a20b0"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.11.102/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "a39a7fe05f92ddbd755ff93ef611bbd0e4e9b642ade3d24df1da8ec99abeed5a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.11.102/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a45727e3a6d9bf8d547bf1e48cefbe2c97dc2f6c90f91827bc7e2710756df75"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.11.102/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d4488cbd7dd0d17524442e262e12880caac6b69b813d423e386241f9524760a7"
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
