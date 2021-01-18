#!/bin/bash

gq https://api.github.com/graphql -H "Authorization: bearer $GITHUB_TOKEN" \
\
-v first=100 \
-q 'query ($first: Int) {
  search(first: $first, type: REPOSITORY, query: "topic:alpinejs") {
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
          createdAt
          description
          forkCount
          isTemplate
          isFork
          nameWithOwner
          stargazerCount
          updatedAt
        }
      }
    }
  }
}
' | jq "{\"when\": \"$(date)\", \"query\": .}" > search.json
