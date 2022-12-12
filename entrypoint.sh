#!/bin/bash
# エラーが発生するとスクリプトを終了する
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /Book-Review/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
