class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.114/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "6a78e7ddfd28fb936c0001c2feaeb01a91b683bf2d5bafd76995988918c885c1"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.114/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "bdcf5b5df3e447a94f58591d62946bc28217e5339b7c7facb4d6e0cfa5abf6cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.114/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d0811e1ee5adabbda48ec75b19862e624e9f48167c0afb21059f3eae67f23bb6"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.114/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fc6b3e1edfc7fb855b0b90fa128428b0d435113cbc2abcbce8dd3e153f1f79c"
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
