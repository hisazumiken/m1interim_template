# M1中間発表 予稿テンプレート

修士1年 中間発表用の予稿LaTeXテンプレートです。

## ファイル構成

| ファイル | 説明 |
|---------|------|
| `m1interim.cls` | ドキュメントクラス（体裁定義） |
| `main.tex` | 予稿本体（編集対象） |
| `refs.bib` | 参考文献データベース |

## 体裁仕様

- 用紙: A4
- 本文: 10pt、2段組（段間 6mm）
- 余白: 上 20mm、下 25mm、左右 20mm
- 欧文フォント: Times New Roman
- 和文フォント: MS 明朝（本文）/ MS ゴシック（見出し）※クラスオプションで変更可
- ページ番号なし

## 予稿の構成

1. 背景
2. 方法
3. 結果
4. 考察
5. 結論
6. 参考文献

※ 2〜4は研究分野に応じて異なる構成でも可。

## 使い方

### 1. `main.tex` のメタ情報を編集

```latex
\jptitle{日本語タイトル}
\entitle{English Title Goes Here}
\department{システム理工学専攻}
\studentid{MF23000}
\studentname{芝浦　太郎}
\labname{○○○○○○○○研究室}
\supervisor{芝浦　工大郎}
```

### 2. 各セクションの本文を記述

### 3. コンパイル（LuaLaTeX + BibTeX）

```bash
latexmk -lualatex main.tex
```

`latexmk` を使わない場合:

```bash
lualatex main.tex
bibtex main
lualatex main.tex
lualatex main.tex
```

## フォントオプション

デフォルトでは MS 明朝/MS ゴシックを使用しますが、クラスオプションでフォントプリセットを切り替えられます。

```latex
\documentclass[haranoaji]{m1interim}  % 原ノ味フォント（TeX Live 同梱）
```

| オプション | フォント | 備考 |
|-----------|---------|------|
| （なし） | MS 明朝 / MS ゴシック | **デフォルト**。Windows 環境向け |
| `haranoaji` | 原ノ味明朝 / 原ノ味ゴシック | TeX Live 同梱。最もポータブル |
| `hiragino-pron` | ヒラギノ明朝 ProN / ヒラギノ角ゴ ProN | macOS 標準 |
| `ipaex` | IPAex 明朝 / IPAex ゴシック | フリー、クロスプラットフォーム |
| `noto-jp` | Noto Serif JP / Noto Sans JP | Google Noto CJK |

MS フォントがない環境（macOS、Linux など）では `haranoaji` を推奨します。

## CI（GitHub Actions）

main ブランチへの push 時に自動で LuaLaTeX ビルドが実行されます。
ビルド済みの PDF は GitHub Actions の Artifact からダウンロードできます。

> **Note:** `*.pdf` は `.gitignore` に含まれているため、リポジトリには PDF を直接追加できません。
> PDF の入手方法は以下のいずれかです:
> - GitHub Actions の Artifact からダウンロード
> - タグを付けて push すると作成される GitHub Release からダウンロード
> - ローカルで `latexmk -lualatex main.tex` を実行して生成

### CI の ON/OFF

| やりたいこと | 方法 |
|---|---|
| CI を完全にオフ | Actions タブ → ワークフロー選択 → `...` → 「Disable workflow」 |
| CI を再びオン | 同メニュー → 「Enable workflow」 |
| 1コミットだけスキップ | コミットメッセージに `[skip ci]` を含める |
| 手動でビルド | Actions タブ → 「Run workflow」 |

README のみの変更など、`.tex` / `.cls` / `.bib` 以外のファイル変更ではビルドは自動スキップされます。

### リリース

タグを付けて push すると、ビルド後に GitHub Release が自動作成され PDF が添付されます。

```bash
git tag v1.0.0
git push origin v1.0.0
```

## 注意事項

- **LuaLaTeX** が必須です（pLaTeX / upLaTeX では動作しません）
- フォントオプション未指定時は MS 明朝・MS ゴシックがシステムにインストールされている必要があります
- CI 環境ではフォントが自動的に原ノ味 / TeX Gyre Termes に切り替わります
- 参考文献スタイルは `unsrt`（引用順）です
