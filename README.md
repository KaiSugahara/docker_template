# docker_template

- 個人用
- 各用途に合わせたdocker-compose.ymlとシェルスクリプトのテンプレート
- 確認：Oracle Cloud Infrastructure インスタンス（Canonical Ubuntu 20.04, VM.Standard.A1.Flex）

## Webサーバ系
| template_name | image(s) | depends_on | 説明 | 注意 |
| :---: | :---: | :---: | :---: | :---: |
| nginx-proxy | jwilder/nginx-proxy:latest<br>jrcs/letsencrypt-nginx-proxy-companion:latest | - | リバースプロキシ<br>Let’s EncryptのSSL証明書 | - |
