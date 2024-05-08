# child_museum

## firestore の Email/Password

```
yaeok.engineer@gmail.com
Yaeo0822
```

## freezed コマンド

```
flutter pub run build_runner build
```

## フォロー・フォロワーの作り

仮にユーザ A さん、B さんを用いての説明

A さんが B さんをフォローした場合
作成される Follow 情報は、以下となる

```
followUid -> BさんのUid
followerUid -> AさんのUid
```

B さんが自分のフォロワーを探すときは、
followUid に自分の Uid が入っているデータを検索しにいく

A さんが自分がフォローしている人を探すときは、
followerUid に自分の Uid が入っているデータを検索しにいく
