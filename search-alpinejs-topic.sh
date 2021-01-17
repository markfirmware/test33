#!/bin/bash
set -x

json_file=alpinejs-topic.json

rm -f report.txt

for user in alpine-collective alpinejs HugoDF kevinbatdorf ryangjchandler SimoTod
do
    echo >> report.txt
    echo $user >> report.txt
    wget -O $json_file \
        --header "Accept: application/vnd.github.v3+json, application/vnd.github.mercy-preview+json" \
        --header "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/users/$user/repos?per_page=100"
    cat $json_file | jq -SC ".[] | .name, .topics" >> report.txt
done

cat report.txt
