![HEADER](https://user-images.githubusercontent.com/61111655/84236820-422abb80-ab33-11ea-8e62-c9cf3bff34f5.png)

### FrePreSNS
###### ~ あなたの表現の自由を守るためのSNS ~ 


#### << ３ヶ月以降、指摘によって判明した問題の解消 >>
カリキュラム終了後、レビューとしてメンターの方にご指摘いただいた問題点を  
レビューの文章を一部引用しQ＆Aの形で独力で解決していきます。  

- [x] NO.1  
【userの詳細画面】  
Q: 末尾のIDがPKのIDでも、optional_idでも表示できますが、optional_idによる表示だけにしてみましょう！  
A: 提出時はfriendly_idというgemを使用してurlに任意の文字列を適応させていましたが、to_paramメソッドを使用してurlを一本化し、gemを使用せずに実現させました。  
[commit:memo:](https://github.com/mkmy1123/FrePreSNS/commit/628899988aa2ba2ac088fb464ed806bff23862e7) : 編集時のコミットはこちら  


- [x] NO.2  
【DM機能】  
Q: チャットに関しては非同期処理に取り組みましょう！  
A: カリキュラム期間中にも挑戦し、チャットの非同期を行うとデザインが崩れてしまったために断念した背景があったのですが、今回、partialの範囲を見直し、送信元が自分か否かで別のpartialを作成することで、非同期通信での作成は自分以外の可能性はないので、jsで自分送信用partialで範囲を追加し無事に非同期通信化できました。  
[pullrequest:rocket:](https://github.com/mkmy1123/FrePreSNS/pull/95) : 編集時のプルリクはこちら


- [ ] NO.3  
【Controller】  
Q: インスタンス変数にしなくても良い、ローカル変数で事足りる記述がいくつか見られます。  
A: 


- [x] NO.4  
【UsersController】  
Q: showアクションの内容とロジックを精査しましょう。  
A: カリキュラム内ではDM機能の作成に精一杯でパフォーマンスにまで気を配れませんでしたが、情報の精査を行い、モデルメソッドへの移植なども行い、リファクタリングを行いました。  
[pullrequest:rocket:](https://github.com/mkmy1123/FrePreSNS/pull/97) : 編集時のプルリクはこちら  

- [ ] NO.5  
【ajax】  
Q: 同じ表記が多いので、共通化できる場所を見つけ、省略しましょう。  
A: 


- [ ] NO.6  
【javascript】  
Q: 命名規則の見直しや記載の統一を行いましましょう。  
A: 


- [ ] NO.7  
【コメントの見直し】  
Q: 備忘録としてのコメントを見直しましょう。  
A: 


- [x] NO.8  
【css/style】  
Q: styleはcssにまとめましょう  
A: ご指摘の箇所はviews/expressions/index.html.slimだったのですが、こちらはkaminariのpaginationにパラメータに送るための変数をstyleと定義していたことによるご指摘でした。これはDB設計の時から問題を起こした言葉選びで、予約語を命名に使用しないことを強く意識していこうと思います。


- [x] NO.9  
【MessagesController】  
Q: pathとして記載した方がよりRailsらしいのではないでしょうか。  
A: 中間テーブルが連なっているDM機能なので相対パスをurlでベタ書きで表記すると理解しやすいなと安易に考えておりましたが、`@message.room`と簡単に書き換えられることにご指摘で気がつきました、非同期通信化によりその表記自体を削除してしまいましたが、今後コードを書いていく上で他の書き方を常に探っていくべきと教えていただきました。  


- [ ] NO.10  
【EventCommentsController】  
Q: createアクションとストロングパラメータを見直しましょう。  
A: 


- [ ] NO.11  
【Rspec】  
Q: テストの精度を気にするのであればカバレッジにこだわってみてください。  
A: メンターの方にsimplecovというgemを教わり、全体網羅できるように別ブランチで鋭意テスト追加中です！  
[AllGreen:traffic_light:](https://github.com/mkmy1123/FrePreSNS/tree/AFTER-CURRICULM/spec)　: 最新のテスト(カバレッジ60％超)　　


