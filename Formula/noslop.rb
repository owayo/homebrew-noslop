class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.108/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "63318c83aa1d643254fc660aea087a4a8911a9230de7f6ccaa2148e1fd9fc42b"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.108/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "3ceacfd2c86579a7a5a7b4b43ada72c7b0963b0eb0c1eaa08150c4c4fca471dd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.108/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd0e5ae31508a4300f579eda8d66ca394749b0cea073726313a5705c80bf1112"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.108/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "947c521a963b28c26ed11f4b79ab97c4b0e2f449c583e296223f8414d120c2b0"
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
