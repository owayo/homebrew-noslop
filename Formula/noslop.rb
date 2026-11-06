class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.11.100/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "a2490b4922ab414658fbd9ec93ca5d8b1e3a5fe629d6808964f5f40039f98d62"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.11.100/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "d000f1c442757886501924230f8ed40d55bf1e6642a14cacab8107a4d9d027bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.11.100/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bec88b2dc508c8fad29f14244940ed3d9f48c0b3c5eec8a930eafb91e833f29d"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.11.100/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4e5e6cbb7a5469299d18fb2e4783e22c4ebbae8e9a9b28de15311af8387058ca"
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
