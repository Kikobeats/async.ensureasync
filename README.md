# ensure-async

![Last version](https://img.shields.io/github/tag/Kikobeats/ensure-async.svg?style=flat-square)
[![Dependency status](http://img.shields.io/david/Kikobeats/ensure-async.svg?style=flat-square)](https://david-dm.org/Kikobeats/ensure-async)
[![Dev Dependencies Status](http://img.shields.io/david/dev/Kikobeats/ensure-async.svg?style=flat-square)](https://david-dm.org/Kikobeats/ensure-async#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/ensure-async.svg?style=flat-square)](https://www.npmjs.org/package/ensure-async)
[![Gratipay](https://img.shields.io/gratipay/Kikobeats.svg?style=flat-square)](https://gratipay.com/~Kikobeats/)

> Wrap an async function and ensure it calls its callback on a later tick of the event loop. Based on [async#ensureAsync](https://github.com/caolan/async#ensureAsync) as module.

## Install

```bash
npm install ensure-async --save
```

If you want to use in the browser (powered by [Browserify](http://browserify.org/)):

```bash
bower install ensure-async --save
```

and later link in your HTML:

```html
<script src="bower_components/ensure-async/dist/ensure-async.js"></script>
```

## Usage

```js
var ensureAsync = require('ensure-async');

function sometimesAsync(arg, callback) {
  if (cache[arg]) {
    return callback(null, cache[arg]); // this would be synchronous!!
  } else {
    doSomeIO(arg, callback); // this IO would be asynchronous
  }
}

// this has a risk of stack overflows if many results are cached in a row
async.mapSeries(args, sometimesAsync, done);

// this will defer sometimesAsync's callback if necessary,
// preventing stack overflows
async.mapSeries(args, ensureAsync(sometimesAsync), done);
```

## API

### ensureAsync(fn)

Wrap an async function and ensure it calls its callback on a later tick of the event loop.  If the function already calls its callback on a next tick, no extra deferral is added. This is useful for preventing stack overflows (`RangeError: Maximum call stack size exceeded`) and generally keeping [Zalgo](http://blog.izs.me/post/59142742143/designing-apis-for-asynchrony) contained.

__Arguments__

* `fn` - an async function, one that expects a node-style callback as its last argument

Returns a wrapped function with the exact same call signature as the function passed in.

## License

MIT © [Kiko Beats](http://www.kikobeats.com)
