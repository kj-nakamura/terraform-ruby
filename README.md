# README

## how to use

### 開発環境構築

* ローカル環境にクローンする
* `docker-compose -d up`コマンドで、コンテナを作成(Dockerがインストールされている前提)
* `bundle install` `rails db:create` `rails db:migrate`でRails環境を作成
* localhost:3000でRailsアプリが表示されたら、開発環境は構築OK

### 本番環境へデプロイ

* circleCIでプロジェクトが作成されていること
* AWS環境が作成されていること
* masterブランチでpush(ブランチ切ってpushして、プルリクマージがおすすめ)
* circleCIを確認して、SECCESSになること
* AWSの該当のALBのDNSに接続して、ローカルと同じアプリが表示されること
* ALBをRoute53に紐付ければ、独自ドメインで接続も可能(未検証)

* Ruby version

ruby-2.6.3

* System dependencies

image:ruby:2.6.3-stretch-node
db:mysql

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
