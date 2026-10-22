class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.111/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "82f7b951dd34c41339043705d5dbc44c5b06c111a9ed5a067d2cd36de04fdc09"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.111/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "6e1a5ea508210e6eaa8374df35b6cf9a2bf877ec794908388d2d4dd3f6a58730"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.111/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a017d5b9dc34a02e5bf43b99cfcf01d0568fcc33e257e0ad4771d3a839580dd5"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.111/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b523995c1827509444a59c5b3744ce4677e255c196dc6c1985a5384ddb339ff"
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
