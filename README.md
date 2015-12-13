# async.ensureasync

![Last version](https://img.shields.io/github/tag/Kikobeats/async.ensureasync.svg?style=flat-square)
[![Dependency status](http://img.shields.io/david/Kikobeats/async.ensureasync.svg?style=flat-square)](https://david-dm.org/Kikobeats/async.ensureasync)
[![Dev Dependencies Status](http://img.shields.io/david/dev/Kikobeats/async.ensureasync.svg?style=flat-square)](https://david-dm.org/Kikobeats/async.ensureasync#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/async.ensureasync.svg?style=flat-square)](https://www.npmjs.org/package/async.ensureasync)
[![Donate](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square)](https://paypal.me/kikobeats)

> Wrap an async function and ensure it calls its callback on a later tick of the event loop. Based on [async#ensureAsync](https://github.com/caolan/async#ensureAsync) as module.

## Install

```bash
npm install async.ensureasync --save
```

If you want to use in the browser (powered by [Browserify](http://browserify.org/)):

```bash
bower install async.ensureasync --save
```

and later link in your HTML:

```html
<script src="bower_components/async.ensureasync/dist/async.ensureasync.js"></script>
```

## Usage

```js
var ensureAsync = require('async.ensureasync');

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
