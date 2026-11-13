# ame-yatagarasu

URL の中身を取ってくる小さなコマンド(curl の代わり。curl と同じオプションを読む。暗号は OpenSSL)。

[ame-shell](https://github.com/TatsuyaM2667/ame-shell)(Wayland のデスクトップシェル)の一部を、単独で使えるように切り出したものです。
ame-shell は画面の要らない仕事を、1 つのことをして標準入出力でやりとりする小さなコマンドに分けています。これはその 1 つです。

## 使い方

```text
ame-yatagarasu: URL の中身を取ってくる(curl の代わり。ame-shell の道具が使う curl のオプションをそのまま読む)。
名前は遠くへ道案内をし、ものを運ぶ八咫烏(やたがらす)から。

  ame-yatagarasu [オプション] URL       中身を標準出力へ(-o で ファイルへ)
    -s / -S / -N           (curl と同じ書き方を受け付ける。出力はいつも届いた分からすぐ書く)
    -f                     HTTP の 400 以上なら中身を書かずに 22 で終わる
    -L                     転送(3xx)をたどる(10 回まで)
    -o ファイル             中身をファイルへ
    -A 名前 / -H "名前: 値" / -X メソッド
    -d / --data-binary 文字 | @ファイル / --data-urlencode 名前=中身   本文を送る(既定のメソッドは POST。2 つ目からは & でつなぐ)
    -G                     本文を URL の ? の後ろに付けて GET で送る
    -w 書式                 最後に書く(%{http_code} を状態コードに置き換える)
    -K -                    設定を標準入力から(url / header / data-binary / user-agent / request = "値")
    --max-time 秒 / --connect-timeout 秒 / --max-filesize バイト

HTTP/1.1 は自分で話し、暗号(TLS 1.2 / 1.3)とサーバの証明書の確認は OpenSSL(libssl)に任せる。
圧縮は頼まない(Accept-Encoding を送らない)。
終了コード(curl と同じ番号): 0 取れた / 2 使い方 / 3 URL が変 / 6 名前を引けない / 7 つながらない /
  22 -f で HTTP の誤り / 23 書けない / 28 時間切れ / 35 暗号の握手に失敗 / 47 転送が多すぎる / 56 受け取りに失敗 /
  60 証明書が正しくない / 63 --max-filesize を超えた
```

## ビルド

```sh
zig build -Doptimize=ReleaseSafe   # zig-out/bin/ame-yatagarasu(Zig 0.13、libc と OpenSSL の libssl)
zig build test
```

## このリポジトリについて

正本は ame-shell の `src/cmd/ame-yatagarasu.zig` です。このリポジトリは `scripts/split-repos.sh` が生成して同期しています。
直したいところがあれば ame-shell の方へお願いします。

ライセンス: GPL-3.0(ame-shell と同じ)
