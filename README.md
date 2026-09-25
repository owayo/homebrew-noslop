# homebrew-noslop

[noslop](https://github.com/owayo/noslop) (日本語の文章から「AI 臭さ」を機械的に拾う Linter) の Homebrew tap です。

## インストール

```bash
brew install owayo/noslop/noslop
```

完全な名前で入れると、その formula が信頼され (Homebrew の [Tap Trust](https://docs.brew.sh/Tap-Trust))、以後は `brew upgrade noslop` のように短い名前で扱えます。

`brew tap owayo/noslop` を先に実行して短い名前で入れる場合は、先に formula を信頼します。信頼していないと、`brew install noslop` は `Refusing to load formula owayo/noslop/noslop from untrusted tap owayo/noslop.` で止まります。

```bash
brew tap owayo/noslop
brew trust --formula owayo/noslop/noslop
brew install noslop
```

## 更新と削除

```bash
brew upgrade noslop
brew uninstall noslop
```

## 対応している環境

| OS | CPU |
|----|-----|
| macOS | Apple Silicon・Intel |
| Linux | x86_64・arm64 |

Windows では、noslop の [Releases](https://github.com/owayo/noslop/releases) からバイナリを取得してください。

## 入るもの

noslop の Releases に添付したビルド済みのバイナリを入れます (ソースからはビルドしません)。形態素解析の辞書はバイナリに同梱しています。

Claude Code・Codex CLI のスキルは入れません。使うなら、入れた後に次を実行します。

```bash
noslop skill-install claude   # Codex CLI なら codex
```

## formula の更新

`Formula/noslop.rb` は、noslop の Release のワークフローが、リリースのたびに新しい版の URL と SHA-256 で書き換えます。手で書き換えないでください。
