![HEADER](https://user-images.githubusercontent.com/61111655/84236820-422abb80-ab33-11ea-8e62-c9cf3bff34f5.png)

### FrePreSNS
###### ~ あなたの表現の自由を守るためのSNS ~ 


ご覧いただきありがとうございます。  
こちらはポートフォリオとして作成したSNS WEBアプリケーションです。   
カリキュラム終了後、３ヶ月以降で手直しを行っている[ブランチはこちら](https://github.com/mkmy1123/FrePreSNS/tree/AFTER-CURRICULM)です。  
![twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Fmkmy1123%2FFrePreSNS)


![TOP PAGE](https://user-images.githubusercontent.com/61111655/84232788-fc1e2980-ab2b-11ea-824f-a00fb2c3a255.png)


<br>
<br>

## FrePreSNSについて
#### \ 表現の自由...？ /

表現の自由についてWikipedia(一部抜粋)には以下のように書かれています。

> Freedom of Expression 【表現の自由】 <br>
> <br>
> 表現の自由（ひょうげんのじゆう）とは、すべての見解を検閲されたり規制されることもなく表明する権利。外部に向かって思想・意見・主張・感情などを表現したり、発表する自由。個人におけるそうした自由だけでなく、報道・出版・放送・映画の（組織による）自由などを含む。

表現の自由を守る。  自由に、思うことを表現するために存在する、FrePreSNSです。

現代には色々な情報が氾濫しすぎています。匿名性を悪用した攻撃が溢れています。  そんな`生きづらい現代のネット上でも、生きやすい世界`を与えたい！

明日を共に生きる、本当の意味での仲間を見つけられるために。


#### \ なんでFrePreSNSを作ったの？ /

私はエンジニアを志す前、俳優として活動していました。  俳優にも思想を持つ権利がありますが、主張すると現代の日本ではとてつもない批判や、信じられないくらい心無い言葉を浴びせられることがあります。

公の目がある中で公開されるなら、きっちりと管理されるなら、  **どんな考え方の人も集まって話したっていい。**

どんな人にも、表現の自由が、守られて欲しかったのです。

<br>
<br>

## Screenshot!
GIF画像を掲載します。  
実際のサイトは[こちらからご覧ください。](https://frepresns.com)


![GIF](https://user-images.githubusercontent.com/61111655/84582098-80212b80-ae22-11ea-85bb-e46cc825cadf.gif)


## 技術面
### 使用言語 / 環境等
-  RubyonRails(5.2.4)
-  Ruby(2.5.7)
-  javascript
-  jQuery
-  yarn

#### \ 特にお世話になったgem や ライブラリ /
- RSpec(テスト)
- FactoryBot(テストデータ作成)
- FullCalender(カレンダー表示)
- Raty.js(星評価)
- kaminari(ページネーション)
- chartkick(グラフ化)
- acts-as-taggable-on(タグ機能)
- ransack(検索機能)
- slim(テンプレートエンジン)
- rubocop-airbnb(静的解析)

### デプロイ環境
- AWS(EC2,ElasticIP,Route53,S3,IAM)
- puma
- nginx
- capistrano


## 設計関連


### データベース定義書
  現行最新版。データベースに関しては不明点があれば、こちらをご覧ください。  
[Googleドキュメントに移動します](https://docs.google.com/spreadsheets/d/1LJDf-PTz2rxxBPnCHkduCCveFnAMm-yxTkbmD6VxaNY/edit#gid=484817952)


### 詳細設計書
  現行最新版。使用gemなどはこちらに詳細に表記してあります。  
[Googleドキュメントに移動します](https://docs.google.com/spreadsheets/d/1ELdvGt2tc8qumAhRqrdeybJLEICKoSfhN-yjP-pc4kQ/edit#gid=2019313919)


### 機能一覧
  使用技術や機能について。特筆すべきものを細かく記しています。   
[Googleドキュメントに移動します](https://docs.google.com/spreadsheets/d/1-G0ooqs94KSpr2QMj2FbsxY0Ie-k0rswbSFvwwAepUI/edit#gid=0)


### 参考までに
  WBSです。初めての自己開発でしたが、計画的に行うことができました。  
[Googleドキュメントに移動します](https://docs.google.com/spreadsheets/d/1tgcUZLeBETO5J1ap4PkeI7nnB0Fe5afuVtAP8pvLnDw/edit#gid=1773513600)

