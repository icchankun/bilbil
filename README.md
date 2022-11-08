<h2 align="center">bilbil - ビルビル</h2>

## **アプリ** 🏢
スムーズに会話を進めたいが、会話を上手く進められない人のためのアプリ「bilbil」

<div align="center">
<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2626303/25a1305e-0a03-13e2-f522-e124074b198c.jpeg" height=300px;/>
</div>

## **アプリ概要** 🗺️
 **｢bilbil｣** ("ビルビル")はスムーズに会話を進めたいけど、それがなかなか上手くいかない人のために **｢ルーレット｣** を使って、**トークテーマや話す順番などを提案してくれる**会話サポートアプリです。

 **｢bilbil｣** とは私が考えた造語で、二つの**bil**を組み合わせで出来ています。

**bil**とは 英単語**build**の省略形です。bilがbuildの省略形というのは自分で勝手に決めました

このアプリが提供した会話サポートによって、スムーズに会話が進み、会話の参加者間で良い雰囲気ができることを願っているので、**このアプリの会話サポートによる会話の流れのbil(作成)** と**会話の参加者間の良い雰囲気のbil(作る)** を組み合わせて**bilbil**としました。

**アプリURL :** https://bil-bil.herokuapp.com/

<img src="https://img.shields.io/badge/-%E8%A8%98%E4%BA%8B-55C500.svg?logo=qiita&style=social"> **:** [【個人開発】スムーズに会話を進めたいが、会話を上手く進められない人のためのアプリ「bilbil」を紹介します。](https://qiita.com/icchankun/items/68dad4c0bdc1e52b684a)

## **ターゲット** 👪
- トークテーマが考えつかず、困っている人
- 会話をスムーズに進めたいが、それがうまくいかない人

## **ユーザーの要求** 🙇
- トークテーマを提供してほしい。
- 会話をスムーズに進めたい。

## **解決方法** 💡
ルーレットを使って、トークテーマを提案する。また、話す順番なども合わせて提案することで、会話の流れを容易に作れるようにする。

## **その他のメリット** 💖
- **会話に集中できる。** <br/>
このアプリにトークテーマや話す順番等の提案を任せておけば、アプリ利用者は、会話により集中することができます。

- **普段しない話をするきっかけができる。** <br/>
ルーレットでトークテーマを決めるので、普段話さないようなことを話すきっかけができます。<br/>
例えば、普段恋愛の話をしない友達の間で、このアプリを使用し、恋愛のトークテーマが提案された場合、恋愛の話をするきっかけになります。

## **使用技術** 🛠️
**フロントエンド** <br/>
HTML/CSS/Scss/Bootstrap5<br/>
Vue.js 3.2.36

**バックエンド**<br/>
Ruby 3.1.2<br/>
Ruby on Rails 6.1.7

**データベース**<br/>
開発環境： Sqlite 3.31.1<br/>
本番環境： PostgreSQL 14.5

**インフラ**<br/>
Heroku (PaaS)

**バージョン管理**<br/>
Git 2.25.1<br/>
GitHub

**開発 OS**<br/>
Ubuntu20.04 (Windows Subsystem for Linux 2)

## **設計** 📑
#### **モックアップ**
https://xd.adobe.com/view/046add9e-7ba0-4025-b4a8-dfa786c14f92-5139/

#### **ER図**
<div align="center">
<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2626303/e680f1b6-1b61-c004-8670-465a40cc2263.png" height=300px;/>
</div>

https://drive.google.com/file/d/1wW9yUARX0z9t1AvDW-zLFKlaVmru8FVO/view?usp=sharing

#### **テーブル設計**
- admins ｢管理者登録情報｣
- categories ｢カテゴリー登録情報｣
- talk_themes｢トークテーマ登録情報｣
- likes｢トークテーマのいいね登録情報｣

https://docs.google.com/spreadsheets/d/1RGY2vqnzNI9LqaRTq1bllk02-v4Z19NX_1FDYa3-SQE/edit?usp=sharing

#### **ルーティング・追加gem/node_modules**
https://docs.google.com/spreadsheets/d/1W7UKUXA5vIITVVvZxCNu5N9a7xppkI3WtVK8O0fD9g0/edit?usp=sharing
