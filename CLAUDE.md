# Coding Agentガイドライン

# その他の重要なルール

## Version Control Best Practices

`git -C`は使用禁止。gitコマンドはproject rootディレクトリから実行すること。

リポジトリ内でファイルを移動する際は、通常の`mv`コマンドではなく必ず`git mv`を使うこと:

```
git mv old_path new_path
```

これによりGitでファイル履歴が保持される。通常の`mv`コマンドを使うと、Gitはファイルの削除と新規作成として認識し、履歴が失われる可能性がある。

### commitはユーザーの明示的な指示を待つこと

ユーザーから明示的に指示されない限り、絶対にcommitしないこと。常に以下の手順を守ること:

1. 依頼されたコード変更を行う
2. formattingとlintingを実行する
3. ユーザーのレビューを待つ
4. 「git commit」「commitして」等の明示的な指示があった場合のみcommitする

これにより、ユーザーがリポジトリにcommitされる前にすべての変更をレビュー・承認できる。
