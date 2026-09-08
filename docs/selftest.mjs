// node selftest.mjs — smallest check that fails if the render logic breaks.
import { readFileSync } from 'node:fs';
import assert from 'node:assert/strict';

const html = readFileSync(new URL('./index.html', import.meta.url), 'utf8');
const js = html.match(/<script>([\s\S]*)<\/script>/)[1].split("$('#q').addEventListener")[0];
const out = { list: {}, stats: {} };
const document = { querySelector: s => (out[s.slice(1)] ??= {}) };
const api = new Function('document',
  `${js}; return { kind, kindLabel, when, list, card, swiftOf, render, hero, DATA: v => DATA = v };`
)(document);
const { kind, kindLabel, when, list, card, swiftOf } = api;

const rel = {
  version: { number: '16.2', build: '16C5032a', release: { release: true } },
  date: { year: 2024, month: 12, day: 11 },
  requires: '14.5',
  sdks: { macOS: [{ number: '15.2' }], iOS: [{ number: '18.2' }] },
  compilers: { swift: [{ number: '6.0.3' }], clang: [{ number: '16.0.0' }] },
  links: { download: { url: 'https://dl.example/x.xip' }, notes: { url: 'https://notes.example' } },
  checksums: { sha1: 'abc123' },
};
const beta = { version: { number: '26.0', build: '17A1', release: { beta: 3 } }, date: { year: 2025, month: 6, day: 9 } };

assert.deepEqual(kind(rel), { key: 'release', family: 'release', label: 'Release', num: null });
assert.equal(kindLabel(kind(beta)), 'Beta 3');
assert.equal(kind(beta).family, 'beta');
assert.equal(kind({ version: { number: '9.0', release: { gmSeed: 2 } } }).family, 'rc');
assert.match(when(rel.date), /2024/);
assert.equal(swiftOf(rel), '6.0.3');
assert.deepEqual(list(rel.sdks), [['iOS', '18.2'], ['macOS', '15.2']]); // SDK_ORDER wins over key order

const h = card(rel);
for (const s of ['16.2', '16C5032a', 'badge release', 'macOS <b>15.2</b>', 'iOS <b>18.2</b>', 'swift <b>6.0.3</b>',
  'macOS 14.5 or later', 'https://notes.example', 'abc123']) {
  assert.ok(h.includes(s), `card() missing ${s}`);
}
// the Download button is the direct .xip, same as xcodereleases.com
assert.ok(h.includes('class="btn primary" href="https://dl.example/x.xip"'), 'Download button is the direct .xip');
assert.ok(h.includes('<dt>Package</dt>') && h.includes('x.xip'), 'package filename shown');
assert.ok(!card(beta).includes('<dt>SDKs'), 'no SDK row when sdks absent');
assert.ok(card(beta).includes('tabindex="0"'), 'card is keyboard focusable (hover-expand needs focus fallback)');
assert.ok(card({ version: { number: '1<b>', release: {} }, date: rel.date }).includes('1&lt;b&gt;'), 'escaping');

// grouping: one <details> per major version, first open and the rest collapsed
const betaDL = { ...beta, links: { download: { url: 'https://dl.example/beta.xip' } } };
api.DATA([{ ...rel, _hay: '16.2' }, { ...betaDL, _hay: '26.0' }]);
api.render();
assert.equal((out.list.innerHTML.match(/<details class="group"/g) || []).length, 2);
assert.equal((out.list.innerHTML.match(/ open>/g) || []).length, 1);
assert.ok(out.list.innerHTML.includes('<h2>Xcode 26</h2>') && out.list.innerHTML.includes('<h2>Xcode 16</h2>'));

// hero CTA: big stable download + beta and App Store secondaries
api.hero();
assert.ok(out.cta.innerHTML.includes('btn primary big') && out.cta.innerHTML.includes('https://dl.example/x.xip'));
assert.ok(out.cta.innerHTML.includes('Download Xcode 16.2'));
assert.ok(out.cta.innerHTML.includes('https://dl.example/beta.xip') && out.cta.innerHTML.includes('Beta 3'));
assert.ok(out.cta.innerHTML.includes('id497799835'));
assert.ok(out.cta.innerHTML.includes('/xcode/whats-new/') && out.cta.innerHTML.includes('/xcode/resources/'));

// no stable download available → big button falls back to the App Store, beta row drops
api.DATA([{ ...beta, _hay: '' }]);
api.hero();
assert.ok(out.cta.innerHTML.includes('btn primary big') && out.cta.innerHTML.includes('id497799835'));
assert.ok(!out.cta.innerHTML.includes('Get beta'), 'no beta button without a download url');

console.log('ok');
