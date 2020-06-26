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


- [ ] NO.2  
【DM機能】  
Q: チャットに関しては非同期処理に取り組みましょう！  
A: 


- [ ] NO.3  
【Controller】  
Q: インスタンス変数にしなくても良い、ローカル変数で事足りる記述がいくつか見られます。  
A: 


- [ ] NO.4  
【UsersController】  
Q: showアクションの内容とロジックを精査しましょう。  
A: 


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


- [ ] NO.8  
【css/style】  
Q: styleはcssにまとめましょう  
A: 


- [ ] NO.9  
【MessagesController】  
Q: pathとして記載した方がよりRailsらしいのではないでしょうか。  
A: 


- [ ] NO.10  
【EventCommentsController】  
Q: createアクションとストロングパラメータを見直しましょう。  
A: 


- [ ] NO.11  
【Rspec】  
Q: テストの精度を気にするのであればカバレッジにこだわってみてください。  
A: メンターの方にsimplecovというgemを教わり、全体網羅できるように別ブランチで鋭意テスト追加中です！

