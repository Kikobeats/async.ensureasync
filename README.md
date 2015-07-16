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
```

## License

MIT © [Kiko Beats](http://www.kikobeats.com)
