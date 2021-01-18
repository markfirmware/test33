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
' > search.json