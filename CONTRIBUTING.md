# Issue駆動開発

Githubを利用するにあたっていくつかのルールを定義します｡

## Issue駆動開発とは

GitHubの運用は[Issue駆動開発](https://gist.github.com/Enchan1207/0ea2c7a7d6a3c16aea5683435d1972f8)で進めていきます｡Issue駆動開発は, ある実装におけるタスクや課題をIssueとして立てて, それに応じたブランチを作成し, コミットやプルリクエストは適宜Issueを参照しながら行っていきます｡

Issue駆動開発では次のようなライフサイクルで開発が進められます｡

1. Issueの作成
2. Issueへのアサイン
3. アサインしたIssueに対応するブランチの作成
4. プルリクエスト作成

## Projects

当リポジトリの[Projects](https://github.com/ex10ds/U22/projects?type=classic)にはフレームワークや技術スタックなどで分割されたいくつかのプロジェクトを追加していきます｡
ProjectsはBasic Kanbanテンプレートで運用するため後述のIssuesと関連しています｡

## Issues

当リポジトリの[Issues](https://github.com/ex10ds/U22/issues)には進行予定または進行中の作業を追加していきます｡
IssueはどれかのProjectsに追加していくため参加したいIssueがある場合は関連付けられたProjectsからIssueのカードを“In progress”へ移動させてください｡

### Issueの作成

新たに進めたい作業がある場合はIssueを作成してください｡ Issueを作成するときは次の項目を吟味してください｡

- Title (タイトル): 必須
- Comment (コメント)
- Assignees (譲受人): 実装時登録
- Labels (ラベル)
- Projects (プロジェクト)

Assigneesは自身が担当する場合は自身のアカウントを選択し, ラベルに関連項目がある場合は追加してください｡

## ブランチ

ブランチは[GitHub Flow](https://gist.github.com/Gab-km/3705015)から派生したルールで運用していきます｡以下の表はブランチの名前や命名規則, 概要を示します｡

| ブランチ名 | 概要 |
| --- | --- |
| main | 新たなIssueの派生元となるブランチ |
| #-* | mainブランチから派生し, 関連するIssueの開発を行うためのブランチ |
| * | 関連のIssueがないブランチや様々なブランチのさらなる派生先のブランチ |

mainブランチへのマージは許可されたGitHubユーザーが行います｡権限のあるユーザーは独断でマージしてください。  
mainブランチから派生したIssueに関するブランチは自由に扱って構いません｡

## コミットメッセージ

コミットメッセージの内容が煩雑にならないために, メッセージには以下の表から該当する接頭辞とコミットの概要を記述することとします｡

| 接頭辞 | 用途 |
| --- | --- |
| add: | ファイルやコードなどの追加 |
| remove: | ファイルやコードなどの削除 |
| fix: | バグの修正 |
| change: | 仕様変更 |
| 無し | どれにも該当しない場合 |

接頭辞を用いたコミットは次のように行われます｡

```bash
git commit -m "add #2: GitHub運用方針を追加"
```

```bash
git commit -m "change #31: 認証方法をsupabaseに変更"
```

Issue駆動開発において上記の例の”#2”や”#31”は必ずしも必要ではありませんが, 関連する場合はつけておくと分かりやすくなります｡

<aside>
💡 #2, #31はissueのPull requestsの番号です。issueに書かれているものを持ってきてください。

</aside>

## プルリクエスト

Issueが解決した場合, mainブランチに対してプルリクエストを作成します｡
プルリクエストのコメントには“close #{関連するIssue}”のようにIssueが自動的にクローズする[キーワード](https://docs.github.com/ja/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue)を追加してください｡
その他にプルリクエストを作成するときは次の項目を吟味してください｡

- Title (タイトル): 必須
- Comment (コメント): 必須
- Assignees (譲受人)
- Labels (ラベル)

関連するIssuesはmainブランチへのマージの際にキーワードを使用することで自動的に関連付けされます。
