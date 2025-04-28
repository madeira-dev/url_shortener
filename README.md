# URL Shortener

This README would normally document whatever steps are necessary to get the
application up and running.

My implementation of this project: https://roadmap.sh/projects/url-shortening-service

This project can be used locally. To do such, clone the repo, start the server and send requests to it.

I built it to be used only through the terminal as it is only an API and not a web application.

To start the server:
```
rails server
```

You can send 5 different requests, they are:
- POST /shorten -> Generate a new slug for a given URL
- GET /shorten/:slug -> Get original URL from given slug
- PUT /shorten/:slug -> Update slug
- DELETE /shorten/:slug -> Delete original URL from given slug
- GET /shorten/:slug/stats -> Get information from the given slug (return the database record)

For example, to create a slug from a given url:
```
curl -X POST http://localhost:3000/shorten \
-H "Content-Type: application/json" \
-d '{"url": {"original_url": "https://example.com"}}'
```
