#!/bin/bash

gq https://api.github.com/graphql -H "Authorization: bearer $GITHUB_TOKEN" \
\
-q '{
  search(first: 100, type: REPOSITORY, query: "topic:alpinejs") {
    pageInfo {
      hasNextPage
      endCursor
      }
    repos: edges {
      repo: node {
        ... on Repository {
          owner {
            login
          }
          name
          url
          id
        }
      }
    }
  }
}' > search.json

cat search.json | jq ".data.search.repos | .[] | .repo | {login:.owner.login, name:.name}"
