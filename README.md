# krill

Unofficial TUI lobste.rs client

# API

// default page
curl https://lobste.rs/hottest -H 'Accept: application/json'

// active
curl https://lobste.rs/active -H 'Accept: application/json'

// recent
curl https://lobste.rs/newest -H 'Accept: application/json'

// story
curl https://lobste.rs/s/r9oskz -H 'Accept: application/json'

// domains
curl 'https://lobste.rs/domains/github.com' -H 'Accept: application/json'

// tags
curl 'https://lobste.rs/tags' -H 'Accept: application/json'

// tag
curl 'https://lobste.rs/t/rust' -H 'Accept: application/json'
curl 'https://lobste.rs/t/rust,ruby' -H 'Accept: application/json'

// pagination
curl '<url>/page/1'
