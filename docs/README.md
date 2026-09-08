# Xcode Releases

Every Xcode release — versions, build numbers, bundled SDKs, Swift and Clang compilers,
release notes and downloads — on one page.

**→ https://abhi21git.github.io/ios-practice/**

One file, no build step, no dependencies. `index.html` fetches
[xcodereleases.com/data.json](https://xcodereleases.com/data.json) at runtime, so it is current
the moment a new Xcode ships; there is nothing to regenerate.

- Collapsible sections per major version, cards that expand on hover
- Search across version, build, SDK and Swift, with release / RC / beta filters
- Light and dark, parallax driven by CSS scroll-driven animations, reduced-motion respected

## Develop

```sh
open index.html      # it is a static file, that is the whole workflow
node selftest.mjs    # asserts the render logic against sample release records
```

Data by [xcodereleases.com](https://xcodereleases.com). Not affiliated with Apple.
