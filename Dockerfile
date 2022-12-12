FROM ruby:2.7.3
# ベースになるイメージ

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client vim
# RailsのインストールやMySQLへの接続に必要なパッケージをインストール

RUN mkdir /Book-Review
# コンテナ内にmyappディレクトリを作成

WORKDIR /Book-Review
# 作成したmyappディレクトリを作業用ディレクトリとして設定

COPY Gemfile /Book-Review/Gemfile
COPY Gemfile.lock /Book-Review/Gemfile.lock
# ローカルの Gemfile と Gemfile.lock をコンテナ内のmyapp配下にコピー

RUN bundle install
# コンテナ内にコピーした Gemfile の bundle install

COPY . /Book-Review
# ローカルのmyapp配下のファイルをコンテナ内のmyapp配下にコピー


# コンテナ起動時に毎回実行されるスクリプトを追加する。
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


CMD ["rails", "server", "-b", "0.0.0.0"]
# イメージ内部のソフトウェア実行
