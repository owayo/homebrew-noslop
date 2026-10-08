class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.105/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "f759ee39ba31834ea46087d54d0b08b0732daa965feba64e9f69a3376feaf1a6"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.105/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "05a8c5124b7c94410f902cad32f2a2ff041a1185580428f67eee65b52ee8622c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.105/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6061b77dde23a2460343e2e638040cd963b008f0c91b6de80eb43ed8d195d15d"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.105/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d83190acbf53bef3585c37785fed770590b0aa7aae48d37e989ef82f8f159406"
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
